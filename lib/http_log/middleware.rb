require 'pp'

module HttpLog
  class Middleware
    attr_accessor :request

    def initialize(app)
      @app = app
    end

    def call(env)
      @proxy = HttpRequest.new(env)

      if passes_filters? && !@proxy.multi_part?
        request = HttpLog::Request.from_request(@proxy)

        HttpLog.callbacks.each do |callback|
          callback.call @proxy, request
        end

        request.save
        env['http_log.request_id'] = request.id.to_s
      end

      @app.call env
    end

    def passes_filters?
      HttpLog.filters.each do |filter|
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
