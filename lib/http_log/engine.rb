module HttpLog
  module ControllerHelpers
    extend ActiveSupport::Concern

    included do
      before_filter :include_http_request_log_id, :if => :http_log_request_id

      def include_http_request_log_id
        logger.info "  HTTP Logger Request ID: #{http_log_request_id}"
        headers['X-Request-Log-ID'] = http_log_request_id
      end

      def http_log_request_id
        request.env['http_log.request_id']
      end
    end
  end

  class Engine < ::Rails::Engine
    isolate_namespace HttpLog

    initializer "http_log.assets" do |app|
      app.config.assets.precompile << 'http_log.js'
      app.config.assets.precompile << 'http_log.css'
    end

    initializer "http_log.middlware" do |app|
      app.middleware.use HttpLog::Middleware
    end

    initializer "http_log.filters" do |app|
      regexp = /assets/
      HttpLog.filters << regexp
    end

    initializer "http_log.action_controller" do
      ActiveSupport.on_load(:action_controller) do
        ActionController::Base.send :include,  HttpLog::ControllerHelpers
      end
    end
  end
end
