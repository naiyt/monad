module Monad
  module GameStates
    class Terminal < GosuStuff::GameState
      PROMPT_PADDING = 0

      def initialize(shell)
        super()

        # The shell-sim colors the output. Turn that off so it can be handled here instead.
        String.disable_colorization = true

        @prompt_text = "nate@monad: "

        @command_line = GosuStuff::TextField.new(@window,
          @font,
          @font.text_width(@prompt_text),
          cli_y_pos,
          background_color = 0x00ffffff)
        @window.text_input = @command_line

        @shell = shell
        @window.caption = 'Monad'

        @text_buffer = []
        @current_script = Scripts::Level1.create(self)
        @new_text = true
      end

      def update
        if @current_input
          add_to_buffer("#{@prompt_text}#{@current_input}")
          res, cmd = @shell.handle_input(@current_input)
          add_res_to_buffer(res)
          @current_input = nil
          @current_script.handle_command(res, cmd)
        end
      end

      def draw
        draw_text_buffer!
        @command_line.draw(Monad::ZOrder::UI)
        @font.draw(@prompt_text, PROMPT_PADDING, cli_y_pos, Monad::ZOrder::UI)
      end

      def button_down(id)
        if id == Gosu::KbReturn
          @current_input = @window.text_input.text
          @window.text_input.text = ''
          @new_text = true
        end
      end

      def add_to_buffer(text)
        @text_buffer << text
      end

      private

      def draw_text_buffer!
        index_offset = 2 # 1 for command prompt, one for zero indexing

        @text_buffer.reverse.each_with_index do |text, index|
          if @font.text_width(text) > @window.width
            first_half = text[0, allowed_chars]
            second_half = text[allowed_chars..-1]
            @font.draw(second_half, PROMPT_PADDING, y_text_pos(index + index_offset), Monad::ZOrder::UI)
            index_offset += 1
            @font.draw(first_half, PROMPT_PADDING, y_text_pos(index + index_offset), Monad::ZOrder::UI)
          else
            @font.draw(text, PROMPT_PADDING, y_text_pos(index + index_offset), Monad::ZOrder::UI)
          end
        end
      end

      def y_text_pos(offset)
        @window.height - (@command_line.height * (offset))
      end

      def allowed_chars
        Integer(@window.width / @font.text_width(' '))
      end

      def add_res_to_buffer(res)
        # TODO: colorize stderr
        res = if res.has_key?(:stderr)
                res[:stderr] || ''
              elsif res.has_key?(:stdout)
                res[:stdout] || ''
              end
        res.split("\n").each { |partial| add_to_buffer(partial) }
      end

      def cli_y_pos
        @window.height - (@font.height + PROMPT_PADDING)
      end
    end
  end
end
