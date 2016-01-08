require_relative 'game/gosu_stuff/gosu_stuff'
require_relative 'game/config/config'
Dir["./game/game_states/*.rb"].each { |f| require f }
Dir["./game/scripts/*.rb"].each { |f| require f }

shell    = ShellSim::Shell.new('root', 'password')
terminal = Monad::GameStates::Terminal.new(shell)

GosuStuff.play(terminal)
