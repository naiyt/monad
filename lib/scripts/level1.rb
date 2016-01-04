module Monad
  module Scripts
    class Level1
      def self.create(terminal)
        ShellSim::Scripts::Script.new(terminal) do
          available_commands [:help, :man]

          output 'HIII'

          expect_cmd :help, 'HELP MEEEEEEE'

          output 'blah'

          expect_cmd :man, 'MAN MEEEEEEE'
        end
      end
    end
  end
end
