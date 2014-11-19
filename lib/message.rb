require 'observer'

# Messages are broken down into prefix (usually the sender),
# the command (PRIVMSG, PING, etc.), the params if there are
# any, and the 'trailing', which is often the message itself
# if there is one.
class Message
  # @todo This class requires extensive cleanup
  # Observed by Plugins
  include Observable

  attr_accessor :prefix, :command, :params, :trailing, :message
  
  def initialize
    @trailing = nil
    @prefix = @command = ''
    @params = []
  end

  def parse(msg)
    prefix_end = trailing_start = -1

    # get prefix if there is one
    if msg[0] == ':'
      prefix_end = msg.index(' ')
      @prefix = msg[1..prefix_end - 1]
    end

    # get trailing if there is one
    trailing_start = msg.index(' :') if msg.index(' :')

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
    @params.reject! { |e| e.to_s.empty? }

    message = {
      prefix:   @prefix,
      command:  @command,
      params:   @params,
      trailing: @trailing
    }

    changed
    notify_observers(message)
  end
end
