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
      result = body.read
      body.rewind
      result
    end

    def multi_part?
      content_type =~ /multipart/i
    end

    def params
      if content_type =~ /json/ && raw_post.present?
        super.merge(MultiJson.decode(raw_post) || {})
      elsif content_type =~ /xml/ && raw_post.present?
        super.merge(Hash.from_xml(raw_post) || {})
      else
        super
      end
    end
  end
end
