require 'gosu_rpg'
require_relative 'lib/config'
require_relative 'lib/terminal'

GosuRPG.play(Monad::Terminal.new)
