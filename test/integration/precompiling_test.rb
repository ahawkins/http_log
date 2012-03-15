require 'test_helper'

class LoggingTest < ActionDispatch::IntegrationTest
  def test_http_log_js_is_precompilable
    assert_includes Rails.application.config.assets.precompile, 'http_log.js'
  end
end
