module Monad
  class Terminal < GosuRPG::GameState
    PROMPT_PADDING = 10

    def initialize
      super

      @window.caption = 'Monad'
      @command_line = GosuRPG::TextField.new(@window, @font,
        PROMPT_PADDING, @window.height - (@font.height + PROMPT_PADDING))
      @window.text_input = @command_line
    end

    def update
      if @current_command
        run_command(@current_command)
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

    private

    def run_command(command)
      puts "Running command: `#{command}`"
    end
  end
end
