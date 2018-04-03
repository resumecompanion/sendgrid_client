require "sendgrid_client/version"
require 'sendgrid_client/configuration'
require 'sendgrid_client/contact'
require 'sendgrid_client/errors'
require 'rest_client'
module SendgridClient
  class << self
    attr_accessor :configuration
  end

  def self.configuration
    @configuration ||= Configuration.new
  end

  def self.configure
    yield(configuration)
  end
end
