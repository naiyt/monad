require 'gosu_rpg'
require_relative 'lib/config/config'
require_relative 'lib/terminal'

shell    = ShellSim::Shell.new('root', 'password')
terminal = Monad::Terminal.new(shell)

GosuRPG.play(terminal)
