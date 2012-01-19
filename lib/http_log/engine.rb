module HttpLog
  class Engine < ::Rails::Engine
    isolate_namespace HttpLog

    initializer "http_log.middlware" do |app|
      app.middleware.use HttpLog::Middleware
    end

    initializer "http_log.filters" do |app|
      regexp = /assets/
      HttpLog.filters << regexp
    end

    initializer "http_log.action_controller" do
      ActiveSupport.on_load(:action_controller) do
        ActionController::Base.send :include,  HttpLog::Controller
      end
    end
  end
end
