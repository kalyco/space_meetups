require 'pry'
require 'rspec'
require 'capybara/rspec'

require_relative '../app.rb'

require 'database_cleaner'

set :environment, :test

Capybara.app = Sinatra::Application

OmniAuth.config.test_mode = true


# makes a mock log in for user testing
def sign_in_as(user)
  mock_omni_auth_for(user)
  visit "/auth/#{user.provider}"
  expect(page).to have_content("You're now signed in as #{user.username}!")
end

def mock_omni_auth_for(user)
  mock_options = {
    uid: user.uid,
    provider: user.provider,
    info: {
      nickname: user.username,
      email: user.email,
      image: user.avatar_url
    }
  }
  OmniAuth.config.add_mock(user.provider.to_sym, mock_options)
end


# clears out my DB after each rspec
RSpec.configure do |config|
  config.filter_run focus: true
  config.run_all_when_everything_filtered = true

  config.before(:suite) do
    DatabaseCleaner.clean_with(:truncation)
  end

  config.before(:each) do
    DatabaseCleaner.strategy = :transaction
  end

  config.before(:each) do
    DatabaseCleaner.start
  end

  config.after(:each) do
    DatabaseCleaner.clean
  end
end
