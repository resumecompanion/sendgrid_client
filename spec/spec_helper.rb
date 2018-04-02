require 'bundler/setup'

Bundler.setup

require "bundler/setup"
require "sendgrid_client"
require 'rspec'
require 'pry'

RSpec.configure do |config|
  # Enable flags like --only-failures and --next-failure

  config.expect_with :rspec do |c|
    c.syntax = :expect
  end

  config.before(:all) do
    SendgridClient.configure do |config|
      config.username = 'test'
      config.password = 'test'
      config.test_mode = true
    end
  end
end
