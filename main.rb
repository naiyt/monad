require_relative 'lib/gosu_stuff/gosu_stuff'
require_relative 'lib/config/config'
Dir["./lib/game_states/*.rb"].each { |f| require f }
Dir["./lib/scripts/*.rb"].each { |f| require f }

script_klass = ARGV[0] == 'freeplay' ? Monad::Scripts::FreePlay : Monad::Scripts::Level1

shell    = ShellSim::Shell.new('root', 'password')
terminal = Monad::GameStates::Terminal.new(shell, [script_klass])

GosuStuff.play(terminal)
