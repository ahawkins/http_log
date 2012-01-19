require 'test_helper'

class ResponseTest < ActionDispatch::IntegrationTest
  test "log ID is included in the response" do
    post echo_path

    log_id = HttpLog::Request.first.id.to_s

    assert_equal log_id, headers['X-Request-Log-ID']
  end
end
