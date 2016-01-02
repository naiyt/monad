WINDOW_WIDTH  = 1280
WINDOW_HEIGHT = 800
FONT_SIZE     = 20

module Monad
  module ZOrder
    BACKGROUND, UI, CURSOR = *0..2
  end
end

def font_path(name)
  "assets/fonts/#{name}.ttf"
end

GosuRPG.configure do |config|
  config.window    = GosuRPG::GameWindow.new(WINDOW_WIDTH, WINDOW_HEIGHT)
  config.font      = font_path('consolas')
  config.font_size = FONT_SIZE
end
