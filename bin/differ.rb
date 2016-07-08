#!/usr/bin/env ruby


def diff(a, b)
  `colordiff --suppress-common-lines -d -x "*microstackshots*" -x '*crash*' -x '*log*' -x 'log*' -bur "#{a}" "#{b}"`
end

def list
  `colordiff -q --suppress-common-lines -d -x "*microstackshots*" -x '*crash*' -x '*log*' -x 'log*' -bur "#{ARGV[0]}/first" "#{ARGV[0]}/last" | cut -d " " -f 2,4`.split("\n")
end

list.each do |line|
  first, last = line.split(/\s+/, 2)
  puts "-----------------------"
  puts "\n\nUse: #{last}\n\n"
  puts "----------------------"
  next unless $stdin.gets.strip.empty?
  puts diff(first, last)
end