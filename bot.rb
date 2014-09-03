#!/usr/bin/env ruby

require 'socket'

class Bot
  def initialize(server, port)
    @channel  = 'darklordpotter'
    @socket   = TCPSocket.open(server, port)
    say "NICK Ozbot"
    say "USER Ozbot 0 * Ozbot"
    say "JOIN ##{@channel}"

  end

  def say msg
    puts msg
    @socket.puts msg
  end

  def kick msg, reason
    nick = msg.split('!')[0]
    nick[0] = ''
    say "KICK ##{@channel} #{nick} :#{reason}"
  end

  def say_to_chan msg
    say "PRIVMSG ##{@channel} :#{msg}"
  end

  def run
    until @socket.eof? do
      msg = @socket.gets
      puts msg

      if msg.match(/^PING :(.*)$/)
        say "PONG #{$~[1]}"
        next
      end

      if msg.match(/PRIVMSG ##{@channel} :(.*)$/)
        content = $~[1]

        #put matchers here
        if content.match("test")
          kick msg, "test!"
        end
      end
    end
  end

  def quit
    say "PART ##{@channel} :Autobots, roll out."
    say 'QUIT'
  end

end

bot = Bot.new("irc.darklordpotter.net", 6667)

trap("INT"){ bot.quit }

bot.run
