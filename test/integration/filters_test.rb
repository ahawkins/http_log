require 'test_helper'

class FiltersTest < ActionDispatch::IntegrationTest
  setup :clear_filters

  test "a symbol is treated a file extension" do
    HttpLogger.filters << :css

    get '/assets/application.css'

    assert_equal 0, HttpLogger::Request.count
  end

  test "a request is ignored if it matches a regex filter" do
    regexp = /assets/
    HttpLogger.filters << regexp

    get 'assets/application.css'

    assert_equal 0, HttpLogger::Request.count
  end

  test "a block can filter requests" do
    HttpLogger.filter do |req|
      true
    end

    get 'assets/application.css'

    assert_equal 0, HttpLogger::Request.count
  end

  private
  def clear_filters
    HttpLogger.filters.clear
  end
end
