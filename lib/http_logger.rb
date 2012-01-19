require 'mongoid'
require 'twitter-bootstrap-rails'
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

  def self.filters
    @filters ||= []
  end

  def self.filter(&block)
    filters << block
  end
end
