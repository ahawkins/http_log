module HttpLogger
  class Middleware
    def initialize(app)
      @app = app
    end

    def call(env)
      @proxy = RequestProxy.new(env.dup)

      if passes_filters?
        request =  HttpLogger::Request.from_request(@proxy)

        HttpLogger.callbacks.each do |callback|
          callback.call @proxy, request
        end

        request.save
        env['http_logger.request_id'] = request.id.to_s
      end

      @app.call env
    end

    def passes_filters?
      HttpLogger.filters.each do |filter|
        matches_filter = if filter.is_a? Symbol
                   @proxy.path_info =~ /\.#{filter}$/
                 elsif filter.is_a? Regexp
                    @proxy.url =~ filter
                 else
                   filter.call @proxy
                 end

        return false if matches_filter
      end

      true
    end

  end
end
