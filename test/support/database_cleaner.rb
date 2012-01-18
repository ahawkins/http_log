require 'database_cleaner'

DatabaseCleaner.orm = :mongoid
DatabaseCleaner.strategy = :truncation

class ActiveSupport::TestCase
  setup :start_database_cleaner
  teardown :clean_database

  def start_database_cleaner
    DatabaseCleaner.start
  end

  def clean_database
    DatabaseCleaner.clean
  end
end
