module GosuRPG
  class GameState
    def initialize
      @config = GosuRPG.config
      @window = @config.window
      if @config.font
        @font = Gosu::Font.new(@config.font_size)
      else
        @font = Gosu::Font.new(@config.font_size, name: @config.font)
      end
    end

    def self.switch(new_state)
      window = GosuRPG.config.window
      window.state.leave if window.state
      window.state = new_state
      new_state.enter
    end

    def update
      raise NotImplemented, 'Your Window class must implement the update method!'
    end

    def draw
      raise NotImplemented, 'Your Window class must implement the draw method!'
    end

    def enter
    end

    def leave
    end

    def button_down(id)
    end
  end
end
