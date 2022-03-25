class BaseController
  def initialize(request)
    @request = request
  end

  def ping
    result = Application::Container["services.ping"].call
    build_response(result)
  end

  def not_found
    build_response("not_found", status: 404)
  end

  private

  def build_response(body, status: 200)
    [status, { "Content-Type" => "text/json" }, [body]]
  end
end