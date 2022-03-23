class BaseController
  def initialize(request)
    @request = request
  end

  def ping
    build_response("pong")
  end

  def message_count(params)
    build_response("it's working", status: 200)
  end

  def not_found
    build_response("not_found", status: 404)
  end

  private

  def build_response(body, status: 200)
    [status, { "Content-Type" => "text/json" }, [body]]
  end
end