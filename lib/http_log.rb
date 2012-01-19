require 'mongoid'
require 'twitter-bootstrap-rails'
require 'http_log/controller'
require 'http_log/request_proxy'
require 'http_log/middleware'
require "http_log/engine"

module HttpLog
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
