require 'socket'
require 'pry'

def scan(port: 1738)
  UDPSocket.new.bind("localhost", port)
rescue Errno::EADDRINUSE
  scan(port: port + 1)
else
  port
end

puts "ewait"
puts scan
