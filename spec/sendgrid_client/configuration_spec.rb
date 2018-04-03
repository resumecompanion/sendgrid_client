require 'spec_helper'

module SendgridClient
  RSpec.describe Configuration do
    context 'configure has been set up' do
      before do
        SendgridClient.configure do |config|
          config.username = 'user'
          config.password = 'password'
        end
      end

      describe '#username' do
        it 'set username by configuration' do
          expect(SendgridClient.configuration.username).to eql 'user'
        end
      end

      describe '#password' do
        it 'set password by configuration' do
          expect(SendgridClient.configuration.password).to eql 'password'
        end
      end
    end

    context 'configuration didn\'t set up ' do
      before do
        SendgridClient.configure do |config|
          config.username = nil
          config.password = nil
        end
      end
      describe '#username' do
        it 'raise Errors::Configuration' do
          expect { SendgridClient.configuration.username }.to raise_error Errors::Configuration
        end
      end

      describe '#password' do
        it 'raise Errors::Configuration' do
          expect { SendgridClient.configuration.password }.to raise_error Errors::Configuration
        end
      end
    end
  end
end
