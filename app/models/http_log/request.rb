module HttpLog
  class Request
    include Mongoid::Document
    include Mongoid::Timestamps

    field :http_method, :type => String
    field :url, :type => String
    field :raw_post, :type => String
    field :remote_ip, :type => String
    field :remote_host, :type => String
    field :user_agent, :type => String
    field :content_type, :type => String
    field :headers, :type => Hash, :default => {}
    field :params, :type => Hash, :default => {}
    field :cookies, :type => Hash, :default => {}

    def self.from_request(rack)
      new do |req|
        req.http_method = rack.request_method
        req.url = rack.url
        req.headers = rack.header_hash
        req.params = rack.params
        req.user_agent = rack.user_agent
        req.content_type = rack.content_type
        req.raw_post = rack.raw_post
        req.remote_ip = rack.ip
        req.cookies = rack.cookies
      end
    end

    def accept
      headers['HTTP_ACCEPT'].present? ? headers['HTTP_ACCEPT'] : nil
    end
  end
end
