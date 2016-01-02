module Monad
  class Terminal < GosuRPG::GameState
    PROMPT_PADDING = 10

    def initialize(shell)
      super()

      # The shell-sim colors the output. Turn that off so it can be handled here instead.
      String.disable_colorization = true

      @shell = shell
      @window.caption = 'Monad'
      @command_line = GosuRPG::TextField.new(@window, @font,
        PROMPT_PADDING, @window.height - (@font.height + PROMPT_PADDING))
      @window.text_input = @command_line
    end

    def update
      if @current_command
        res, cmd = @shell.handle_commands(@current_command)
        @window.text_input.text = res
        @current_command = nil
      end
    end

    def draw
      @command_line.draw(Monad::ZOrder::UI)
    end

    def button_down(id)
      if id == Gosu::KbReturn
        @current_command = @window.text_input.text
        @window.text_input.text = ''
      end
    end
  end
end
