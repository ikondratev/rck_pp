require 'minitest/autorun'
require './app/services/ping'

module Test
  class TestServices < Minitest::Test

    def setup
      @ping_service = Services::Ping.new
    end

    def test_service_ping
      result = @ping_service.call
      assert_equal("pong", result)
    end
  end
end