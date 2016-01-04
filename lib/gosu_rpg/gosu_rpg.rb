require 'gosu'
require_relative 'gosu_rpg/config'
require_relative 'gosu_rpg/exceptions'
require_relative 'gosu_rpg/text_field'
require_relative 'gosu_rpg/game_window'
require_relative 'gosu_rpg/game_state'

module GosuRPG
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
