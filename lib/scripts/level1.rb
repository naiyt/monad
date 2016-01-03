module Monad
  module Scripts
    class Level1
      def self.create
        ShellSim::Scripts::Script.new(terminal) do
          available_commands [:help, :man]

          expect_cmd :help, 'HELP MEEEEEEE'

          expect_cmd :man, 'MAN MEEEEEEE'
        end
      end
    end
  end
end
