module HttpLog
  class RequestProxy < SimpleDelegator
    def initialize(env)
      @action_dispatch_request = ActionDispatch::Request.new(env)
      __setobj__ @action_dispatch_request
    end

    def accepts
      Array.wrap(@action_dispatch_request.accepts).map(&:to_s)
    end

    def header_hash
      header_keys = env.keys.select {|k| k =~ /HTTP_\w+/ }
      hash = {}
      header_keys.each do |key|
        hash[key] = headers[key]
      end
      hash
    end

    private
    def action_dispatch_request
      @action_dispatch_request
    end
  end
end
