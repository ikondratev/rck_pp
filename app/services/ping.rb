module Services
  class Ping
    RESPONSE_PING = "pong".freeze

    def call
      RESPONSE_PING
    end
  end
end
