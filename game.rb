require_relative 'lib/gosu_stuff/gosu_stuff'
require_relative 'lib/config/config'
Dir["./lib/game_states/*.rb"].each { |f| require f }
Dir["./lib/scripts/*.rb"].each { |f| require f }

shell    = ShellSim::Shell.new('root', 'password')
terminal = Monad::GameStates::Terminal.new(shell)

GosuStuff.play(terminal)
