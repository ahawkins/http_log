$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "http_log/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "http_log"
  s.version     = HttpLog::VERSION
  s.authors     = ["Adam Hawkins"]
  s.email       = ["me@broadcastingdam.com"]
  s.homepage    = "https://github.com/twinturbo/http_log"
  s.summary     = "Log HTTP requests to MongoDB for debugging and access them via the web"

  s.files = Dir["{app,config,db,lib}/**/*"] + ["MIT-LICENSE", "Rakefile", "readme.md"]
  s.test_files = Dir["test/**/*"]

  s.add_dependency "rails", "~> 3.1"
  s.add_dependency "jquery-rails"
  s.add_dependency "mongoid"
  s.add_dependency "bson_ext"
  s.add_dependency "sass-rails"

  s.add_development_dependency "database_cleaner"
end
