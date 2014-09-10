#!/usr/bin/env ruby

require 'socket'
require 'yaml'
require_relative 'irc/parser'

class Asimov
CONFIG = YAML.load_file('config.yml') unless defined? CONFIG

  def initialize(server, port)
    @socket   = TCPSocket.open(server, port)

    @parser   = Parser.new
    @channels = CONFIG['channels']
    @nick     = CONFIG['nick']
    
    say "NICK #{@nick}"
    say "USER #{@nick} 0 * #{@nick}"
  end

  def say msg
    puts msg
    @socket.puts msg
  end

  def say_to_chan chan, msg
    say "PRIVMSG #{chan} :#{msg}"
  end

  def run
    until @socket.eof? do
      msg = @socket.gets
      puts msg

      # Connect to channels
      
    
      if msg.match(/^PING :(.*)$/)
        say "PONG #{$~[1]}"
        next
      end
    end
  end

  def quit
    @channels.each do |c|
      say "PART #{c['name']} #{CONFIG['quit_message']}"
    end
    say "QUIT"
  end

end

bot = Asimov.new("irc.darklordpotter.net", 6667)

trap("INT"){ bot.quit }

bot.run
