module Monad
  module GameStates
    class Terminal < GosuStuff::GameState
      PROMPT_PADDING = 0

      def initialize(shell)
        super()

        # The shell-sim colors the output. Turn that off so it can be handled here instead.
        String.disable_colorization = true

        @shell = shell
        @window.caption = 'Monad'

        @command_line = GosuStuff::TextField.new(@window, @font,
          PROMPT_PADDING, @window.height - (@font.height + PROMPT_PADDING))
        @window.text_input = @command_line

        @text_buffer = ''

        @current_script = Scripts::Level1.create(self)

        @new_text = true
      end

      def update
        if @current_input
          add_to_buffer(@current_input)
          res, cmd = @shell.handle_input(@current_input)
          add_res_to_buffer(res)
          @current_input = nil
          @current_script.handle_command(res, cmd)
          @new_text = true
        end
      end

      def draw
        if @new_text
          @text_image = Gosu::Image.from_text(@text_buffer.chomp,
            @font.height,
            font: @font.name,
            width: cli_width
          )

          @new_text = false
        end

        @text_image.draw(0, scrollback_y_pos(@text_image), Monad::ZOrder::UI)

        @command_line.draw(Monad::ZOrder::UI)
      end

      def button_down(id)
        if id == Gosu::KbReturn
          @current_input = @window.text_input.text
          @window.text_input.text = ''
        end
      end

      def add_to_buffer(text)
        @text_buffer += "#{text}\n"
      end

      private

      def add_res_to_buffer(res)
        # TODO: colorize stderr
        res = if res.has_key?(:stderr)
                res[:stderr] || ''
              elsif res.has_key?(:stdout)
                res[:stdout] || ''
              end
        res.split("\n").each { |partial| add_to_buffer(partial) }
      end

      def cli_width
        @window.width # TODO: subtract the prompt width
      end

      def scrollback_y_pos(text)
        @window.height - text.height - @command_line.height
      end
    end
  end
end
