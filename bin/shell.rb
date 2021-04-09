require "shell"
require "rainbow"

class Capture < String
  def input=(input)
    input.map(&:strip).each(&method(:concat))
  end

  def active?
    true
  end
end

Shell.verbose = false

%w[grep git sed head echo].each do |cmd|
  Shell.def_system_command(cmd)
end

class Command < Shell
  def capture(&block)
    Capture.new.tap do |capture|
      transact do
        instance_eval(&block) | capture
      end
    end
  end
end

define_method(:sh) do
  @sh ||= Command.new
end

def say(*args)
  puts "%s %s" % [Rainbow("==>").color(:yellow), args.join(" ")]
end

def say!(*args)
  puts "%s %s" % [Rainbow("==>").color(:red), args.join(" ")]
end

def esay!(*args)
  say!(*args)
  exit 1
end

def esay(*args)
  say(*args)
  exit 0
end
