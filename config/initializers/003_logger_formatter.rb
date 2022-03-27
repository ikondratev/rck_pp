class JsonLoggerFormatter < ::Logger::Formatter
  HANDLER_TYPES = {
    CLIENT_REQUEST: "client_request",
    CLIENT_RESPONSE: "client_response",
    ERROR: "error"
  }.freeze

  def call(severity, time, app_name, message)
    json = JSON.dump(
      {
        time: time,
        severity: severity,
        data: build_message(message),
        app_name: app_name.to_s
      }
    )

    "#{json}\n\n"
  end

  private

  def build_message(message)
    return { message: message } unless message.is_a? Hash

    case message[:type]
    when HANDLER_TYPES[:CLIENT_REQUEST]
      client_request(message)
    when HANDLER_TYPES[:CLIENT_RESPONSE]
      client_response(message)
    when HANDLER_TYPES[:ERROR]
      error(message)
    else
      default(message)
    end
  end

  def client_request(message)
    {
      request: {
        log_group: message[:log_group],
        log_name: message[:log_name],
        started_at: message[:started_at],
        url: message[:url].to_s,
        body: message[:body],
        headers: message[:headers]
      }
    }
  end

  def client_response(message)
    {
      response: {
        log_group: message[:log_group],
        log_name: message[:log_name],
        operation_time: message[:operation_time],
        status: message[:status],
        url: message[:url].to_s,
        body: message[:body],
        headers: message[:headers]
      }
    }
  end

  def error(message)
    keys = %i[log_group log_name operation_time]
    {
      error: {
        type: message[:error],
        message: message[:message],
        backtrace: message[:backtrace]
      }
    }.merge(message.dup.slice(keys))
  end

  def default(message)
    keys = %i[method controller action message params status status_message
              allocations_count event_duration format path location filename]
    message.dup.slice(keys)
  end
end