module Monad
  module Scripts
    class Level1
      def self.create(terminal)
        ShellSim::Scripts::Script.new(terminal) do
          level_name 'Tutorial'

          available_commands [:help, :man]

          output "Loading tutorial..."

          output "You will now be guided through command line basics."

          expect_cmd :task, "If at any time you forget your current task, use the command 'task' to receive a reminder. Do so now."

          output "Well done."

          expect_cmd :help, "Throughout this tutorial you will add new commands to your arsenal. Use the command 'help' to list all of your available commands."

          expect_cmd_with_args :man, :man, "Each command comes with a 'manual'. You can read a commands manual page with the 'man' command. For example, to read the manual for the command 'help' you would use the command 'man help'. Read the manual page for the 'man' command."

          output "Level 1 of the tutorial has been completed. Be sure to remember the commands 'help', 'task', and 'man'."
        end
      end
    end
  end
end
