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
        newlined_buffer = @text_buffer.map { |txt| add_newlines(txt) }.flatten

        newlined_buffer.reverse.each_with_index do |text, index|
          x = PROMPT_PADDING
          y = @window.height - (@command_line.height * (index + 2))
          @font.draw(text, x, y, Monad::ZOrder::UI)
        end
      end

      def add_newlines(text)
        return text unless too_wide?(text)
        first_half = text[0...allowed_chars]
        second_half = text[allowed_chars..-1]
        return [first_half, add_newlines(second_half)]
      end

      def too_wide?(text)
        @font.text_width(text) > @window.width
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
