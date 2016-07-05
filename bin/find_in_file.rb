# DSL for defining cli commands
# avalible methods; config, command and filter
# exported commands: find, locate

# Global config
config do
  # Print each command
  debug true

  # Abort if any command fails
  stop_on_error true

  # Run from path
  path :called

  # Run String#scrub and String#squeeze after each command
  default_pipes "method:squeeze", "method:scrub"

  # Maximum time each command can run
  timeout 10
end

command :locate, bin: "/usr/bin/locate", export: true do
  # Configs can be set as a second argument
  # to #command or via the global config block

  # Pass final output to these methods/filters/commands
  # "method:linewise:x" passes each line to Ruby method "x"
  # "filter:everything:y" pipes output to filter "y" (defined using filter {})
  # "command:linewise:z" pipes output to command "z" (defined using command {})
  # :everything is the default operator
  redirect_to "method:linewise:strip",
    "filter:everything:truncate"
    "command:linewise:head(limit:10)"

  # If export=true: discription must exist
  description "Recursive search for content"

  # Send output to filter:print with argument
  # limit=10. Disregard output (:intercept), like Object#tap
  pipe "filter:everything:intercept:print(limit:10)" do
    # Run: locate /path/to/folder
    # On status code 0: continue as normal
    # On status code 1: raise an error
    # On status code 2: bubble to the top of the command
    #   ignoring all pipes and return "nothing"
    on [:return, :fail, :bubble] do
      action :folder do |folder|
        run(folder)
      end
    end

    # Run: locate .
    # Uses the already existing "folder" action with folder=.
    action current: { folder:  "." }

    # Run: locate /
    # Attaching description to action
    action "Start search from root folder", root: { folder:  "/" }
  end
end

# Command: find <path>|.
command :find, export: true do
  # Called if one argument is passed
  action :default do |path|
    # Return if any if the commands succeeds
    run or: [
      "command:locate:path(#{path})",
      "native:mdfind(#{path})",
      "native:grep(#{path})"
    ]
  end

  # Called if no arguments are passed
  action :default do
    run or: [
      "command:locate:current",
      "native:mdfind(.)",
      "native:grep(-iR, .)"
    ]
  end
end

# Print to console. #run not allowed
filter :print do
  # Default action called when running "filter:print"
  # Requires the argument "limit"
  action :default, ["limit"] do |number|
    # If the data being passed in an array
    on Array do |lines|
      print "First: #{lines[0...n]}"
    end

    # Otherwise reverse
    on :rest do |data|
      print "Reverse: #{data[0...n].reverse}"
    end
  end
end

# Make path relative by removing the current path
# #current_path is global and points to the current folder
filter :truncate do
  path.gsub(current_path, "")
end
