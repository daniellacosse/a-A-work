# This file is copied to spec/ when you run 'rails generate rspec:install'
ENV["RAILS_ENV"] ||= 'test'
require File.expand_path("../../config/environment", __FILE__)
require 'rspec/rails'
require 'rspec/autorun'
require 'capybara/rspec'


# Requires supporting ruby files with custom matchers and macros, etc,
# in spec/support/ and its subdirectories.
Dir[Rails.root.join("spec/support/**/*.rb")].each { |f| require f }

# Checks for pending migrations before tests are run.
# If you are not using ActiveRecord, you can remove this line.
ActiveRecord::Migration.check_pending! if defined?(ActiveRecord::Migration)

RSpec.configure do |config|
  # ## Mock Framework
  #
  # If you prefer to use mocha, flexmock or RR, uncomment the appropriate line:
  #
  # config.mock_with :mocha
  # config.mock_with :flexmock
  # config.mock_with :rr

  # Remove this line if you're not using ActiveRecord or ActiveRecord fixtures
  config.fixture_path = "#{::Rails.root}/spec/fixtures"

  # If you're not using ActiveRecord, or you'd prefer not to run each of your
  # examples within a transaction, remove the following line or assign false
  # instead of true.
  config.use_transactional_fixtures = true

  # If true, the base class of anonymous controllers will be inferred
  # automatically. This will be the default behavior in future versions of
  # rspec-rails.
  config.infer_base_class_for_anonymous_controllers = false

  # Run specs in random order to surface order dependencies. If you find an
  # order dependency and want to debug it, you can fix the order by providing
  # the seed, which is printed after each run.
  #     --seed 1234
  config.order = "random"
end

def sign_up_example_user
  visit new_user_url
  fill_in 'username', with: 'example_username'
  fill_in 'password', with: 'example_password'
  click_on "Create User"
end

def sign_in_example_user
  user = FactoryGirl.create(:user)
  visit new_session_url
  fill_in 'username', with: 'example_username'
  fill_in 'password', with: 'example_password'
  click_on "Sign In"
end

def create_example_goal
  visit new_goal_url
  fill_in "New Goal Name", with: "my_sample_goal"
  fill_in "Description", with: "my_sample_goal_description"
  select "Public", from: "This Goal is:"
  click_on "Create New Goal"
end

def create_example_comment_on_goal
  sign_in_example_user
  create_example_goal
  fill_in "New Comment", with: "my_sample_comment"
  click_on "Submit New Comment"
end

def create_example_comment_on_user
  sign_in_example_user
  fill_in "New Comment", with: "my_sample_comment"
  click_on "Submit New Comment"
end


# this goal is:
# => public
# => private