module HttpLogger
  class Engine < ::Rails::Engine
    initializer "http_logger" do |app|
      app.middleware.use HttpLogger::Middleware
    end

    initializer "http_logger.action_controller" do
      ActiveSupport.on_load(:action_controller) do
        ActionController::Base.send :include,  HttpLogger::Controller
      end
    end
  end
end
