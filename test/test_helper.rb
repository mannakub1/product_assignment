# require 'simplecov'

# SimpleCov.minimum_coverage 51
# SimpleCov.start 'rails' do
#   add_filter 'lib/'
# end

ENV['RAILS_ENV'] ||= 'test'
require_relative '../config/environment'
require 'rails/test_help'
require 'minitest/autorun'
require 'mocha/minitest'
# require 'database_cleaner'

class ActiveSupport::TestCase
  include FactoryBot::Syntax::Methods
  include Rack::Test::Methods
  parallelize(workers: 1)


  setup do
    Rails.cache.clear
  end

  def app
    Rails.application
  end

  def response_body
    JSON.parse(last_response.body).deep_symbolize_keys
  end

  def user_header(user)
    headers = {}
    headers["HTTP_AUTH_TOKEN"] = ApplicationService.new.jwt_encoder(user)
    headers
  end

  # Run tests in parallel with specified workers
  # parallelize(workers: :number_of_processors)

  # Setup all fixtures in test/fixtures/*.yml for all tests in alphabetical order.
  # fixtures :all

  # Add more helper methods to be used by all tests here...
end
