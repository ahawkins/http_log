module HttpLogger
  class Middleware
    def initialize(app)
      @app = app
    end

    def call(env)
      request =  HttpLogger::Request.from_request(RequestProxy.new(env))

      HttpLogger.callbacks.each do |callback|
        callback.call env, request
      end

      request.save
      env['http_logger.request_id'] = request.id.to_s

      @app.call env
    end
  end
end
