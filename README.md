# Monad

This is an under construction engine for creating "hacking" games, complete with a scripting engine, a shell simulator (including the concept of STDIN, STDOUT, piping, and output redirection), a bunch of Unix-y commands, a "filesystem", and a GUI built with [gosu](https://github.com/gosu/gosu). Think [Hacknet](http://store.steampowered.com/app/365450/), [hackmud](http://store.steampowered.com/app/469920/?snr=1_5_9__300), [Uplink](http://store.steampowered.com/app/1510/), etc.

![Hacking demo](/images/hacking.gif)

## Running

```
git clone git@github.com:naiyt/monad.git
cd monad
bundle install
ruby main.rb freeplay
```

## Things this can do

* All of the commands [here](https://github.com/naiyt/monad/tree/master/lib/shell_sim/commands) have been implemented and run in some way

* Pipes work (more or less), as does output redirection with both > and >>. Try something like this:

```ruby
[root@hacksh /]: echo "Hacking for fun and profit!" > test.txt
[root@hacksh /]: ls
tmp   usr   etc   home   test.txt
[root@hacksh /]: echo "Unix/Linux/OSX/Solaris" > test2.txt
[root@hacksh /]: cat test.txt
Hacking for fun and profit!
[root@hacksh /]: cat test.txt | grep Hacking
Hacking for fun and profit!
[root@hacksh /]: cat test2.txt | grep Hacking
[root@hacksh /]:
```

* The concept of stderr and stdout exists
* The concept of users with passwords exists
* You can make and delete files and directories
* A command can have a `man` page by implementing the `manual` method

## Things this can't do yet

* Filesystem changes aren't persisted between program runs
* No concept of user permissions exists
* No text editors of any sort. (To write to a file, use echo and output redirection.)
* A billion other things


## Scripting

[Examples](https://github.com/naiyt/monad/tree/master/lib/scripts)

Monad includes a scripting DLS that can be used to essentially create "levels". These can be used to teach the user various concepts as well as give them designated goals.

Example

```ruby
ShellSim::Scripts::Script.new(terminal) do
  level_name 'Tutorial'

  available_commands [:help, :man]

  output "Loading tutorial..."

  output "You will now be guided through command line basics."

  expect_cmd :task, "If at any time you forget your current task, use the command 'task' to receive a reminder. Do so now."

  output "Well done."

  output "And another"

  expect_cmd :help, "Throughout this tutorial you will add new commands to your arsenal. Use the command 'help' to list all of your available commands."

  expect_cmd_with_args :man, :man, "Each command comes with a 'manual'. You can read a commands manual page with the 'man' command. For example, to read the manual for the command 'help' you would use the command 'man help'. Read the manual page for the 'man' command."

  output "Level 1 of the tutorial has been completed. Be sure to remember the commands 'help', 'task', and 'man'."
end
```

### Currently available scripting methods

NOTE: "Block" in this context means to not proceed to the next script expectation. The user's interaction with the shell will NOT be blocked.

* `expect_cmd` (symbol of command, optional text) - Use if you want to block until the user enters a specific command
* `expect_cmd_with_args` (symbol of cmd, array of symbols with expected args, optional text) - Use if you want to block until the user enters a specific command with specific args
* `expect_pwd_to_be` (symbol of directory, optional text) - Use if you want to block until the user is in a specific directory
* `expect_file_to_exist` (symbol representing filepath, optional text) - Block until the specified file exists in the filesystem
- `expect_dir_to_exist` - not yet implemented, will raise an exception
- `expect_current_user_to_be` (username symbol, optional text) - block until the current user is the specified user (e.g., to test someone "hacking" into another user's account)

## Implementing a command

[Examples](https://github.com/naiyt/monad/tree/master/lib/shell_sim/commands)

A command must be created as a class that inherits from `Command` and implements the `Run`
method.

Your `command` object will have access to the following:

* `args`: an array of command line arguments
* `get_input`: retrieves `stdin` (whether piped from a command or typed by the user)

Return `nil` or `false` from `run` if you wish the command to complete silently. Otherwise, just return a string that you want to go to `stdout`.

If you want to write to `stderr`, your `run` method should return a hash in the following format: `{ stderr: 'Error message' }`.

Here's an example of a pointless command called `cool`. If you pass this command a list of names it will state their coolness factor. If you pass it no names, it will send an error to stderr.

```ruby
module ShellSim
  module Commands
    class Cool < Command
      def self.manual
        <<-EOS.strip_heredoc
          cool - determine the coolness of people.

          Usage: cool [list of names]
        EOS
      end

      def run
        if args.length == 0
          { stderr: "Nobody is cool..." }
        else
          args.map { |person| "#{person} is #{coolness_levels.sample} cool!" }.join("\n")
        end
      end

      private

      def coolness_levels
        ["pretty", "very", "extremely", "not very", "overwhelmingly", "freezing"]
      end
    end
  end
end
```

```
[root@hacksh /]: cool Tanya Nate Kira Christa Sean
Tanya is overwhelmingly cool!
Nate is very cool!
Kira is pretty cool!
Christa is overwhelmingly cool!
Sean is pretty cool!
```

## Architecture

Still working on writing this.

## TODO

## See Also

This project is an amalgamation of two previous projects of mine:

https://github.com/naiyt/shell-sim (the shell, filesystem, and commands)
https://github.com/naiyt/hacking_game (the scripting engine)

This combines the two of those and adds the GUI. Initially I kept those as separate gems and included them as a dependency in this one, but for ease of development they've all been rolled into one.
