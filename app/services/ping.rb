module Services
  class Ping
    RESPONSE_PING = "pong".freeze

    # @return [String]
    def call
      RESPONSE_PING
    end
  end
end
