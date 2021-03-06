require 'yaml'
require_relative '../shell_sim/shell_sim'

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

ShellSim.configure do |config|
  config.fs_data    = YAML.load_file('lib/config/fs_fixture.yml')
  config.users_data = YAML.load_file('lib/config/users_fixture.yml')
end

GosuStuff.configure do |config|
  config.window     = GosuStuff::GameWindow.new(WINDOW_WIDTH, WINDOW_HEIGHT)
  config.font       = font_path('consolas')
  config.font_size  = FONT_SIZE
  config.font_color = 0xff00ff00
end
