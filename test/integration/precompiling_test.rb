require 'test_helper'

class PrecompilingTest < ActionDispatch::IntegrationTest
  def test_http_log_js_is_precompilable
    assert_includes Rails.application.config.assets.precompile, 'http_log.css'
  end
end
