require 'common'
require 'net/ssh'

module NetSSH
  class TestStartOptions < NetSSHTest
    def setup
      authentication_session = mock('authentication_session')
      authentication_session.stubs(:authenticate).returns(true)
      Net::SSH::Authentication::Session.stubs(:new).returns(authentication_session)
      Net::SSH::Transport::Session.stubs(:new).returns(mock('transport_session'))
      Net::SSH::Connection::Session.stubs(:new).returns(mock('connection_session'))
    end

    def test_start_should_accept_keepalive_option
      assert_nothing_raised do
        options = { :keepalive => true }
        Net::SSH.start('localhost', 'testuser', options)
      end
    end

    def test_start_should_accept_keepalive_interval_option
      assert_nothing_raised do
        options = { :keepalive_interval => 10 }
        Net::SSH.start('localhost', 'testuser', options)
      end
    end

    def test_start_should_accept_send_env_option
      assert_nothing_raised do
        options = { :send_env => [ /^LC_.*$/, "LANG" ] }
        Net::SSH.start('localhost', 'testuser', options)
      end
    end

    def test_start_should_accept_number_of_password_prompts_option
      assert_nothing_raised do
        options = { :number_of_password_prompts => 2 }
        Net::SSH.start('localhost', 'testuser', options)
      end
    end

    def test_start_should_accept_non_interactive_option
      assert_nothing_raised do
        options = { :non_interactive => true }
        Net::SSH.start('localhost', 'testuser', options)
      end
    end

    def test_start_should_accept_remote_user_option
      assert_nothing_raised do
        options = { :remote_user => 'foo' }
        Net::SSH.start('localhost', 'testuser', options)
      end
    end

    def test_constructor_should_reject_options_set_to_nil
      assert_raises(ArgumentError) do
        options = { :remote_user => nil}
        Net::SSH.start('localhost', 'testuser', options)
      end
    end

    def test_constructor_should_reject_invalid_options
      assert_raises(ArgumentError) do
        options = { :some_invalid_option => "some setting"}
        Net::SSH.start('localhost', 'testuser', options)
      end
    end
  end
end

