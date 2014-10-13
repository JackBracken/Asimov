require 'minitest/autorun'
require 'irc/message'

class TestMessage < Minitest::Test
  def setup
    @privmsg      =  Message.new(':Foo!uid1234@some.host.net PRIVMSG #channel :Test message')
    @user_action  =  Message.new(':Foo!uid1234@some.host.net PRIVMSG #channel :ACTION test action')
    @user_mode    =  Message.new(':Foo!uid1234@some.host.net MODE #channel +o Asimov')
  end

  def test_parse_prefix
    assert_equal 'Foo!uid1234@some.host.net', @privmsg.prefix
    assert_equal 'Foo!uid1234@some.host.net', @user_action.prefix
    assert_equal 'Foo!uid1234@some.host.net', @user_mode.prefix
  end

  def test_parse_trailing
    skip
    assert_equal 'Test message', @privmsg.trailing
    assert_equal 'ACTION test action', @user_action.trailing
    assert_equal '', @user_mode.trailing
  end

  def test_parse_command
    skip
    assert_equal 'PRIVMSG', @privmsg.command
    assert_equal 'PRIVMSG', @user_action.command
    assert_equal 'MODE', @user_mode.command
  end

  def test_parse_params
    skip
  end
end