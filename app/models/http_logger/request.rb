module HttpLogger
  class Request
    include Mongoid::Document
    include Mongoid::Timestamps

    field :http_method, :type => String
    field :url, :type => String
    field :content_type, :type => String
    field :raw_post, :type => String
    field :remote_ip, :type => String
    field :remote_host, :type => String
    field :user_agent, :type => String
    field :accept, :type => Array
    field :headers, :type => Hash, :default => {}
    field :params, :type => Hash, :default => {}

    def self.from_request(env)
      new do |req|
        req.http_method = env.request_method
        req.url = env.url
        req.headers = env.header_hash
        req.params = env.parameters
        req.content_type = env.content_type
        req.accept = env.accepts
        req.user_agent = env.user_agent
        req.raw_post = env.raw_post
        req.remote_ip = env.remote_ip
        req.remote_host = env.remote_host if env.remote_host.present?
      end
    end
  end
end
