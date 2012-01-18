require 'test_helper'

class LoggingTest < ActionDispatch::IntegrationTest
  test "sending a http requests creates a log entry" do
    post echo_path

    assert_equal 1, HttpLogger::Request.count
  end

  test "the http method is logged" do
    post echo_path

    req = HttpLogger::Request.first

    assert_equal 'POST', req.http_method
  end

  test "the url is logged" do
    post echo_path

    req = HttpLogger::Request.first

    assert_equal echo_url, req.url
  end

  test "query string is included in the url" do
    post echo_path(:foo => :bar) 

    req = HttpLogger::Request.first

    assert_equal echo_url(:foo => :bar), req.url
  end

  test "headers are logged" do
    post echo_path, {}, {'HTTP_FOO' => 'bar'}

    req = HttpLogger::Request.first

    assert req.headers.has_key?('HTTP_FOO')
    assert_equal 'bar', req.headers['HTTP_FOO']
  end

  test "paramters are logged" do
    post echo_path, :foo => :bar

    req = HttpLogger::Request.first

    assert req.params.has_key?('foo')
    assert_equal 'bar', req.params['foo']
  end

  test "json encoded parameters are logged" do
    post echo_path, %Q{{"foo": "bar"}}, {'CONTENT_TYPE' => 'application/json'}

    req = HttpLogger::Request.first

    assert req.params.has_key?('foo')
    assert_equal 'bar', req.params['foo']
  end

  test "query string parameters are logged" do
    post echo_path(:foo => :bar)

    req = HttpLogger::Request.first

    assert req.params.has_key?('foo')
    assert_equal 'bar', req.params['foo']
  end

  test "content type is logged" do
    post echo_path, {}, {'CONTENT_TYPE' => 'application/json'}

    req = HttpLogger::Request.first

    assert_equal 'application/json', req.content_type
  end

  test "http accept header is logged" do
    post echo_path, {}, {'HTTP_ACCEPT' => 'application/json'}

    req = HttpLogger::Request.first

    assert_equal ['application/json'], req.accept
  end

  test "raw post data is logged" do
    post echo_path, :foo => :bar

    req = HttpLogger::Request.first

    assert_equal 'foo=bar', req.raw_post
  end

  test "custom callbacks are executed" do
    HttpLogger.with_request do |env, log|
      log.headers['foo'] = 'bar'
    end

    post echo_path

    req = HttpLogger::Request.first

    assert_equal 'bar', req.headers['foo']
  end

  test "multiple callbacks are allowed" do
    HttpLogger.with_request do |env, log|
      log.headers['foo'] = 'bar'
    end

    HttpLogger.with_request do |env, log|
      log.headers['baz'] = 'quz'
    end

    post echo_path

    req = HttpLogger::Request.first

    assert_equal 'quz', req.headers['baz']
  end
end
