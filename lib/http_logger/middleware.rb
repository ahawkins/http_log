module HttpLogger
  class Middleware
    def initialize(app)
      @app = app
    end

    def call(env)
      request =  HttpLogger::Request.create_from_request(RequestProxy.new(env))
      env['http_logger.request_id'] = request.id.to_s
      @app.call env
    end
  end
end
