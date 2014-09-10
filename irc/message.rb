class Message
  attr_accessor :prefix, :command, :params, :trailing

  def initialize

  end

  def parse msg
    if msg[0] == '!'
      prefix_end = msg.index(' ')
      @prefix = msg.partition
    end
  end
end