require 'mongoid'
require 'http_logger/controller'
require 'http_logger/request_proxy'
require 'http_logger/middleware'
require "http_logger/engine"

module HttpLogger
  def self.with_request(&block)
    callbacks << block
  end

  def self.callbacks
    @callbacks ||= []
  end
end
