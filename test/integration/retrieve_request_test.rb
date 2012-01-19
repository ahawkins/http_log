require 'test_helper'

class RetreiveRequestTest < ActionDispatch::IntegrationTest
  include HttpLog::Engine.routes.url_helpers

  test "engine mounts a controller to get a specific request" do
    req = HttpLog::Request.create

    get http_request_path(req), :format => :json

    assert_equal response.body, req.to_json
  end
end
