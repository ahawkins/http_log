module HttpLogger
  class Engine < ::Rails::Engine
    isolate_namespace HttpLogger

    initializer "http_logger.middlware" do |app|
      app.middleware.use HttpLogger::Middleware
    end

    initializer "http_logger.filters" do |app|
      regexp = /assets/
      HttpLogger.filters << regexp
    end

    initializer "http_logger.action_controller" do
      ActiveSupport.on_load(:action_controller) do
        ActionController::Base.send :include,  HttpLogger::Controller
      end
    end
  end
end
