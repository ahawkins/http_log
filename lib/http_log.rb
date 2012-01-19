require 'mongoid'
require 'http_log/http_request'
require 'http_log/middleware'
require 'twitter-bootstrap-rails'
require "http_log/railtie"

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