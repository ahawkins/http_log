require 'test_helper'

class FiltersTest < ActionDispatch::IntegrationTest
  setup :clear_filters

  test "a symbol is treated a file extension" do
    HttpLog.filters << :css

    get '/assets/application.css'

    assert_equal 0, HttpLog::Request.count
  end

  test "a request is ignored if it matches a regex filter" do
    regexp = /assets/
    HttpLog.filters << regexp

    get 'assets/application.css'

    assert_equal 0, HttpLog::Request.count
  end

  test "a block can filter requests" do
    HttpLog.filter do |req|
      true
    end

    get 'assets/application.css'

    assert_equal 0, HttpLog::Request.count
  end

  private
  def clear_filters
    HttpLog.filters.clear
  end
end
