module HttpLog
  class HttpRequest < Rack::Request
    def accepts
      Array.wrap(super).map(&:to_s)
    end

    def header_hash
      header_keys = env.keys.select {|k| k =~ /HTTP_\w+/ }
      hash = {}
      header_keys.each do |key|
        hash[key] = env[key]
      end
      hash
    end

    def accepts
      env['HTTP_ACCEPT']
    end

    def raw_post
      content = env['rack.input'].read
      env['rack.input'].rewind
      content
    end

    def params
      super.merge(env['action_dispatch.request.request_parameters'] || {})
    end
  end
end
