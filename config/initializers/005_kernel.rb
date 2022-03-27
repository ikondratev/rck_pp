module Kernel
  def li(payload)
    Application::Container["logger"].log(Logger::INFO, payload)
  end

  def lw(payload)
    Application::Container["logger"].log(Logger::WARN, payload)
  end

  def le(payload)
    Application::Container["logger"].log(Logger::ERROR, payload)
  end

  def lf(payload)
    Application::Container["logger"].log(Logger::FATAL, payload)
  end

  def safe(category = :common)
    yield
  rescue StandardError => e
    Application::Container["logger"].error(
      event: category,
      data: {
        message: e.message,
        backtrace: e.backtrace
      }
    )
  end
end
