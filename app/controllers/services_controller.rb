class ServicesController < BaseController
  def ping
    result = Application::Container["services.ping"].call
    build_response(result)
  end
end
