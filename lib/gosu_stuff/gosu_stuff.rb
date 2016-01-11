require 'gosu'
require_relative './text_field'
require_relative './game_window'
require_relative './game_state'

#
# Config

module GosuStuff
  class Config
    attr_accessor :default_caption, :window, :font_size, :font, :font_color
  end
end

module GosuStuff
  def self.configure
    yield config
  end

  def self.config
    @config ||= Config.new
  end

  def self.reset
    @config = Config.new
  end

  def self.play(initial_state)
    GameState.switch(initial_state)
    config.window.show
  end
end


#
# Custom exceptions

module GosuStuff
  class NotImplemented < StandardError
  end
end
