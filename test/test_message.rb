require 'minitest/autorun'
require 'message'

class TestMessage
  def setup
    @msg = Message.new
  end

  def test_parse_prefix
    assert_match /Foo!uid1234@some.host.net/ @msg.parse(":Foo!uid1234@some.host.net PRIVMSG #channel :Test message")
  end
end