ENV['RAILS_ENV'] ||= 'test'
require_relative '../config/environment'
require 'rails/test_help'
require 'minitest-spec-rails'
require 'database_cleaner'
require 'support/database_cleaner_support'

ActionController::API.config.allow_forgery_protection = false

class ActiveSupport::TestCase
  # Run tests in parallel with specified workers
  parallelize(workers: :number_of_processors)

  # Setup all fixtures in test/fixtures/*.yml for all tests in alphabetical order.
  fixtures :all

  # Add more helper methods to be used by all tests here...
  include FactoryBot::Syntax::Methods

  def serialize(resource)
    ActiveModelSerializers::SerializableResource.new(resource).as_json.stringify_keys
  end
end
