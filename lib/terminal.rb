module Monad
  class Terminal < GosuRPG::GameState
    PROMPT_PADDING = 0

    def initialize(shell)
      super()

      # The shell-sim colors the output. Turn that off so it can be handled here instead.
      String.disable_colorization = true

      @shell = shell
      @window.caption = 'Monad'

      @command_line = GosuRPG::TextField.new(@window, @font,
        PROMPT_PADDING, @window.height - (@font.height + PROMPT_PADDING))
      @window.text_input = @command_line

      @text_buffer = []

      @current_script = Scripts::Level1.create(self)
    end

    def update
      if @current_command
        add_to_buffer(@current_command)
        res, cmd = @shell.handle_commands(@current_command)
        res = '' unless res
        res.split("\n").each { |partial| add_to_buffer(partial) }
        @current_command = nil
        @current_script.handle_command(res, cmd)
      end
    end

    def draw
      @text_buffer.reverse.each_with_index do |text, index|
        x = PROMPT_PADDING
        y = @window.height - (@command_line.height * (index + 2))
        @font.draw(text, x, y, Monad::ZOrder::UI)
      end

      @command_line.draw(Monad::ZOrder::UI)
    end

    def button_down(id)
      if id == Gosu::KbReturn
        @current_command = @window.text_input.text
        @window.text_input.text = ''
      end
    end

    def add_to_buffer(text)
      @text_buffer << text
    end
  end
end
