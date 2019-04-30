# frozen_string_literal: true

ENV['RAILS_ENV'] = 'test'
require File.expand_path('../config/environment', __dir__)
require 'rails/test_help'
require 'minitest/rails'
require 'minitest/reporters' # for Colorized output
#  For colorful output!
Minitest::Reporters.use!(
  Minitest::Reporters::SpecReporter.new,
  ENV,
  Minitest.backtrace_filter
)

# To add Capybara feature tests add `gem "minitest-rails-capybara"`
# to the test group in the Gemfile and uncomment the following:
# require "minitest/rails/capybara"

# Uncomment for awesome colorful output
# require "minitest/pride"

class ActiveSupport::TestCase
  # Setup all fixtures in test/fixtures/*.yml for all tests in alphabetical order.
  fixtures :all

  def login_as(user = nil)
    user ||= User.first
    params = {
      user: {
        username: user.username
      }
    }
    post login_path, params: params
  end
end
