require 'spec_helper'
require 'dotenv'
require 'webmock/rspec'
require File.expand_path('../../config/environment', __FILE__)
require 'rspec/rails'
ENV['RAILS_ENV'] ||= 'test'
abort("The Rails environment is running in production mode!") if Rails.env.production?
ActiveRecord::Migration.maintain_test_schema!
Dotenv.load


Dir[Rails.root.join("spec/support/**/*.rb")].each { |f| require f }

RSpec.configure do |config|
  config.fixture_path = "#{::Rails.root}/spec/fixtures"
  config.use_transactional_fixtures = true
  config.infer_spec_type_from_file_location!
  config.filter_rails_from_backtrace!
  config.include FactoryBot::Syntax::Methods
  config.include LogIn
end
Shoulda::Matchers.configure do |config|
  config.integrate do |with|
    with.test_framework :rspec
    with.library :rails
  end
end
