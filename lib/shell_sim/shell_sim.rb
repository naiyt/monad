require_relative 'shell_sim/config'
require_relative 'shell_sim/output_helper'
require_relative 'shell_sim/commands_helper'
require_relative 'shell_sim/exceptions'
require_relative 'shell_sim/filesystem'
require_relative 'shell_sim/shell'
require_relative 'shell_sim/user'
require_relative 'shell_sim/scripting'

Dir['./lib/shell_sim/shell_sim/commands/*.rb'].each { |f| require f }

module ShellSim
  def self.configure
    yield config
  end

  def self.config
    @config ||= Config.new
  end

  def self.reset
    @config = Config.new
  end
end

# http://stackoverflow.com/a/5638187/1026980
class String
  def strip_heredoc
    gsub /^#{self[/\A[ \t]*/]}/, ''
  end
end
