ENV['RAILS_ENV'] ||= 'test'
require File.expand_path('../../config/environment', __FILE__)
require 'rails/test_help'
require 'capybara/rails'

class ActiveSupport::TestCase
  DatabaseCleaner.strategy = :truncation

  self.use_transactional_tests = false

  def setup
    DatabaseCleaner.clean
  end
end
