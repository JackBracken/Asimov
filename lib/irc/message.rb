class Message
  attr_accessor :prefix, :command, :params, :trailing

  def initialize msg
    @trailing
    @prefix = @command = ''
    @params = { }

    if msg[0] == ':'
      prefix_end = msg.index(' ')
      @prefix = msg[1..prefix_end - 1]
    end

    trailing_start = msg.index(' :')
    if trailing_start >= 0
      @trailing = msg[(trailing_start + 2)..(msg.size - 1)]
    else
      @trailing = msg.size
    end
  end
end