WINDOW_WIDTH  = 1280
WINDOW_HEIGHT = 800
FONT_SIZE     = 50

module Monad
  module ZOrder
    BACKGROUND, UI, CURSOR = *0..2
  end
end

GosuRPG.configure do |config|
  config.window    = GosuRPG::GameWindow.new(WINDOW_WIDTH, WINDOW_HEIGHT)
  config.font_size = FONT_SIZE
end
