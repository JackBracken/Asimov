class Message
  attr_accessor :prefix, :command, :params, :trailing

  def initialize

  end

  def parse msg
    if msg[0] == ':'
      prefix_end = msg.index(' ')
      @prefix = msg[1..prefix_end - 1]
      
    end
  end
end

msg = Message.new
msg.parse(":Jack!uid1859@some.host.net PRIVMSG #channel :placeholder message")
msg.parse(":Jack!uid1859@some.host.net PRIVMSG #channel :ACTION placeholder action")
msg.parse(":Jack!uid1859@some.host.net MODE #channel +o Asimov")