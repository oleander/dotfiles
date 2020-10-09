require "rubocop"
require "colorize"

class MyFormat < RuboCop::Formatter::SimpleTextFormatter
  def report_file(file, offenses)
    output.puts yellow("#{smart_path(file)}")
    index = 0
    s = {}

    colors = [:light_white, :light_cyan, :light_magenta, :light_blue, :light_yellow, :light_green, :light_red].reverse
    color = lambda do |value|
      y = s[value]
      next y if y
      sync = colors[index % colors.count]
      x = value.colorize(sync)
      index += 1
      s[value] = x
      x
    end

    offenses.each do |o|
      both, message = *o.message.split(": ", 2)
      type, name = *both.split("/", 2)
        output.printf(
        "%<icon>s  %<type>-15s\t%<line>s:%<column>s\t%<message>30s\n",
        severity: colored_severity_code(o),
        line: o.line.to_s.colorize(:light_black),
        column: o.real_column.to_s.colorize(:light_black),
        type: color.call(type),
        name: name,
        message: message.italic,
        icon: o.correctable? ? "👌" : "💣"
      )
    end
  end
end
