class Logger::LogDevice
  def add_log_header(file); end
end

class AppLogger < ::ActiveSupport::Logger
  def log(severity, payload)
    case severity
    when Logger::WARN
      Application::Container["logger"].warn(payload)
    when Logger::ERROR
      Application::Container["logger"].error(serve_error_payload(payload))
    when Logger::FATAL
      Application::Container["logger"].fatal(payload)
    else
      Application::Container["logger"].info(payload)
    end
  end

  private

  def serve_error_payload(err)
    if err.is_a?(Exception)
      {
        type: JsonLoggerFormatter::HANDLER_TYPES[:ERROR],
        error: err.class,
        message: err.message,
        backtrace: err.backtrace.first
      }
    else
      {
        type: JsonLoggerFormatter::HANDLER_TYPES[:ERROR],
        message: err
      }
    end
  end
end

env = ::ActiveSupport::StringInquirer.new(ENV["RACK_ENV"] || "development")

file_format = "log/#{Time.now.to_i}_#{env}.log"
logger = ::AppLogger.new(file_format, 0)
logger.formatter = ::JsonLoggerFormatter.new
Application::Container.register(:logger, logger)