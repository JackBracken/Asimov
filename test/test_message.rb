require 'test_helper'
require 'irc/message'

class TestMessage < Minitest::Test
  def setup
    @privmsg      =  Message.new(':Foo!uid@some.host PRIVMSG #chan :Test')
    @user_action  =  Message.new(':Foo!uid@some.host PRIVMSG #chan :ACTION test action')
    @user_mode    =  Message.new(':Foo!uid@some.host MODE #chan +o Asimov')
  end

  def test_parse_prefix
    assert_equal 'Foo!uid@some.host', @privmsg.prefix
    assert_equal 'Foo!uid@some.host', @user_action.prefix
    assert_equal 'Foo!uid@some.host', @user_mode.prefix
  end

  def test_parse_trailing
    assert_equal 'Test', @privmsg.trailing
    assert_equal 'ACTION test action', @user_action.trailing
    assert_nil @user_mode.trailing
  end

  def test_parse_command
    assert_equal 'PRIVMSG', @privmsg.command
    assert_equal 'PRIVMSG', @user_action.command
    assert_equal 'MODE', @user_mode.command
  end

  def test_parse_params
    assert_equal '#chan', @privmsg.params[0]
    assert_equal '#chan', @user_action.params[0]
    assert_equal '#chan', @user_mode.params[0]
    assert_equal '+o',       @user_mode.params[1]
    assert_equal 'Asimov',   @user_mode.params[2]
  end
end