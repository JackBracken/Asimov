#!/usr/bin/env ruby

require 'socket'
require 'yaml'

module Asimov
  CONFIG = YAML.load_file('config.yml') unless defined? CONFIG

  class Bot
    def initialize(server, port)
      @socket   = TCPSocket.open(server, port)

      @channels = CONFIG['channels']
      @nick     = CONFIG['nick']

      say "NICK #{@nick}"
      say "USER #{@nick} 0 * #{@nick}"

      authenticated = false

      until authenticated
        msg = @socket.gets
        puts msg

        if msg.match(/^PING :(.*)$/)
          say "PONG #{Regexp.last_match[1]}"
          next
        end

        authenticated = true if msg.include?("End of \/MOTD command")
      end

      @channels.each do |chan|
        say "JOIN #{chan['name']}"
      end

      puts @socket.gets
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

        if msg.match(/^PING :(.*)$/)
          say "PONG #{Regexp.last_match[1]}"
          next
        end
      end
    end

    def quit
      @channels.each do |c|
        say "PART #{c['name']} :#{CONFIG['quit_message']}"
      end
      say 'QUIT'
    end
  end
end

bot = Asimov::Bot.new('irc.darklordpotter.net', 6667)
trap('INT') { bot.quit }
bot.run
