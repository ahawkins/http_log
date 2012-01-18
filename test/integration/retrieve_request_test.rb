require 'test_helper'

class RetreiveRequestTest < ActionDispatch::IntegrationTest
  include HttpLogger::Engine.routes.url_helpers

  test "engine mounts a controller to get a specific request" do
    req = HttpLogger::Request.create

    get http_request_path(1), :format => :json, :id => req.id

    assert_equal response.body, req.to_json
  end
end
