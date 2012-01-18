require 'pp'

module HttpLogger
  class Request
    include Mongoid::Document
    include Mongoid::Timestamps

    field :http_method, :type => String
    field :url, :type => String
    field :content_type, :type => String
    field :raw_post, :type => String
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
        req.raw_post = env.raw_post
      end
    end
  end
end
