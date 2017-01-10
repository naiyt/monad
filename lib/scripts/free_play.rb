module Monad
  module Scripts
    class FreePlay
      def self.create(terminal)
        ShellSim::Scripts::Script.new(terminal) do
        end
      end
    end
  end
end
