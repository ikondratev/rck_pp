require_relative "config/application"
require_all "./config/app"

secret_key = SecureRandom.hex(32)
use Rack::Session::Cookie, secret: secret_key, same_site: true, max_age: 86400

run Rack::URLMap.new('/' => Rack::Builder.new { run App.new })