require_relative 'shell_sim/output_helper'
require_relative 'shell_sim/commands_helper'
require_relative 'shell_sim/filesystem'
require_relative 'shell_sim/shell'
require_relative 'shell_sim/user'
require_relative 'shell_sim/scripting'

Dir['./lib/shell_sim/shell_sim/commands/*.rb'].each { |f| require f }

#
# Config

module ShellSim
  class Config
    attr_accessor :users_data, :fs_data

    def initialize
    end
  end
end

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


#
# Custom exceptions

module ShellSim
  module Commands
    class NotImplemented < StandardError
    end
  end

  module Filesystem
    class AlreadyExistsError < StandardError
    end

    class FileDoesNotExistError < StandardError
    end

    class DirectoryNotEmptyError < StandardError
    end

    class FileAlreadyExists < StandardError
    end

    class PathDoesNotExist < StandardError
    end

    class FileNotDir < StandardError
    end
  end
end


#
# Patches

# http://stackoverflow.com/a/5638187/1026980
class String
  def strip_heredoc
    gsub /^#{self[/\A[ \t]*/]}/, ''
  end
end
