require_relative 'lib/gosu_rpg/gosu_rpg'
require_relative 'lib/config/config'
require_relative 'lib/terminal'
Dir["./lib/scripts/*.rb"].each {|file| require file }

shell    = ShellSim::Shell.new('root', 'password')
terminal = Monad::Terminal.new(shell)

GosuRPG.play(terminal)
