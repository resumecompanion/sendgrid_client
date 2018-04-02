require "rails_helper"

RSpec.describe SendgridClient do
  describe '#configuration' do
    subject { SendgridClient.configuration }
    it { is_expected.to be_a_kind_of(SendgridClient::Configuration) }
  end

  describe '#configure' do
    subject { SendgridClient.configure }
    it 'give block to yield' do
      expect { |config| SendgridClient.configure(&config) }.to yield_control
      expect { |config| SendgridClient.configure(&config) }.to yield_with_args(SendgridClient.configuration)
    end

    it 'pass Configuration instance to yield block' do
      SendgridClient.configure do |config|
        expect(config).to be_a_kind_of(SendgridClient::Configuration)
      end
    end
  end
end
