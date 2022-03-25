require "dry/system/container"

module Application
  class Container < Dry::System::Container
    configure do |config|
      config.root = Dir.pwd
      config.name = :application
      config.auto_register = %w[
        app/services
      ]
    end

    load_paths!("app")
  end
end

module Application
  Import = Application::Container.injector
end