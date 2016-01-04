require_relative 'lib/gosu_stuff/gosu_stuff'
require_relative 'lib/config/config'
require_relative 'lib/terminal'
Dir["./lib/scripts/*.rb"].each {|file| require file }

shell    = ShellSim::Shell.new('root', 'password')
terminal = Monad::Terminal.new(shell)

GosuStuff.play(terminal)
