# HTTP Logger

Logs all requests made to your application in a search format to
MongoDB. This gem includes a middleware to log rack requests to MongodB.
It also adds a header to every response indicating an `id` that can be
used to retrieve that request. You can combine this header and the one's
added by rails to track the conversation applications are having with 
your application.

## Installation

This gem using Mongoid to store the models. Once you install the gem,
run the mongoid config generator to setup the connection.

```
gem 'http_logger'

bundle install

bundle exec rails g mongoid:config
```

## Example of What is Logged

```javascript
{
  "_id":"4f16c6c4340765d7c5000005",
  "url":"http://www.example.com/",
  "http_method":"POST",
  "accept":["text/html","application/xml","image/png","text/plain","*/*"],
  "content_type":"application/json",
  "raw_post":"{\"foo\": \"bar\"}",
  "params":{
    "foo":"bar"
  },
  "headers":{
    "HTTP_HOST":"www.example.com",
    "HTTP_ACCEPT":"text/xml,application/xml,application/xhtml+xml,text/html;q=0.9,text/plain;q=0.8,image/png,*/*;q=0.5",
    "HTTP_COOKIE":""
  },
  "created_at":"2012-01-18T15:19:00+02:00",
  "updated_at":"2012-01-18T15:19:00+02:00"
}
```

## Adding More Log Information

You can add has many callbacks as you'd like. They are executed inside
the middleware after the initial log is instantiated. Callbacks are ran,
then the log is persisted. 

Let's say you want to add some more headers of your own:

```ruby
# config/initializers/http_logger.rb
# req is an ActionDispatch::Request
# log is the HttpLogger::Request instance

HttpLogger.with_request |log, req|
  log.headers['Custom-Foo'] = 'bar'
end
```

You may also add your own fields by reopneing the class and using the
Mongoid APi.

```ruby
# config/initializers/http_logger.rb
class HttpLogger:Request
  field :developer_api_key, :type => String
end

HttpLogger.with_request |log, req|
  log.developer_api_key = req.parameters['developer_api_key']
end
```
