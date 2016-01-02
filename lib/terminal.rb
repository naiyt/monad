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
    end

    def draw
      @command_line.draw(Monad::ZOrder::UI)
    end
  end
end
