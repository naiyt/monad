module GosuRPG
  class GameWindow < Gosu::Window
    attr_accessor :state

    def initialize(width, height, fullscreen=false)
      super width, height, fullscreen
    end

    def update
      @state.update
    end

    def draw
      @state.draw
    end

    def button_down(id)
      close if id == Gosu::KbEscape
      @state.button_down(id)
    end
  end
end
