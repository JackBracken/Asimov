class Message
  attr_accessor :prefix, :command, :params, :trailing

  def initialize msg
    @trailing
    @prefix = @command = ''
    @params = []
    prefix_end = trailing_start = -1
    
    # get prefix if there is one
    if msg[0] == ':'
      prefix_end = msg.index(' ')
      @prefix = msg[1..prefix_end - 1]
    end

    # get trailing if there is one
    if msg.index(' :') then trailing_start = msg.index(' :') end
    
    if trailing_start >= 0
      @trailing = msg[(trailing_start + 2)..(msg.size - 1)]
    else
      trailing_start = msg.size
    end

    # get command and paramaters
    cmd_with_params = msg[prefix_end + 1..trailing_start - 1].split(' ')

    @command = cmd_with_params[0]
    @params = cmd_with_params[1..-1]
    
    # remove any empty or nil elements that slip in
    @params.reject!{ |e| e.tos_.empty? }    
  end
end
