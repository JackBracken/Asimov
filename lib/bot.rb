#!/usr/bin/env ruby

require 'socket'
require 'yaml'

# Main bot class
class Asimov
  CONFIG = YAML.load_file('config.yml') unless defined? CONFIG
  def connect(server, port)
    @socket   = TCPSocket.open(server, port)

    @channels = CONFIG['channels']
    @nick     = CONFIG['nick']

    say "NICK #{@nick}"
    say "USER #{@nick} 0 * #{@nick}"

    authenticate

    @channels.each do |chan|
      say "JOIN #{chan['name']}"
    end

    puts @socket.gets
  end

  def authenticate
    authenticated = false
    until authenticated
      msg = @socket.gets
      puts msg

      pong(msg)

      authenticated = true if msg.include?("End of \/MOTD command")
    end
  end

  def say(msg)
    puts msg
    @socket.puts msg
  end

  def say_to_chan(chan, msg)
    say "PRIVMSG #{chan} :#{msg}"
  end

  def run
    until @socket.eof?
      msg = @socket.gets
      puts msg
      pong(msg)
    end
  end

  def quit
    @channels.each do |c|
      say "PART #{c['name']} :#{CONFIG['quit_message']}"
    end
    say 'QUIT'
  end

  def pong(msg)
    say "PONG #{Regexp.last_match[1]}" if msg.match(/^PING :(.*)$/)
  end
end

bot = Asimov.new
bot.connect('irc.darklordpotter.net', 6667)
trap('INT') { bot.quit }
bot.run
