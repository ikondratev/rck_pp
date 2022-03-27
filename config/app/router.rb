class Router

  def initialize(request)
    @request = request
  end

  def route!
    return controller.not_found unless @request.post?

    case @request.path
    when Constants::Routes::PING
      controller.ping
    when Constants::Routes::MESSAGE_COUNT
      controller.message_count(params)
    else
      controller.not_found
    end
  end

  private

  def controller
    @controller ||= ServicesController.new(@request)
  end

  def params
    JSON.parse(@request.body.read)
  end
end
