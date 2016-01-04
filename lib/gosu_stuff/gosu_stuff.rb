require 'gosu'
require_relative 'gosu_stuff/config'
require_relative 'gosu_stuff/exceptions'
require_relative 'gosu_stuff/text_field'
require_relative 'gosu_stuff/game_window'
require_relative 'gosu_stuff/game_state'

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
