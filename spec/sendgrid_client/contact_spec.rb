require 'rails_helper'

module SendgridClient
  RSpec.describe Contact do
    let(:contact) { described_class.new }
    let(:end_point) { contact.send(:end_point) }

    describe '.update' do
      subject { described_class.update({}) }
      it 'call update instance method' do
        allow_any_instance_of(described_class).to receive(:update)

        expect_any_instance_of(described_class).to receive(:update).with({})

        subject
      end
    end

    describe '.delete' do
      subject { described_class.delete('') }
      it 'call delete instance method' do
        allow_any_instance_of(described_class).to receive(:delete)

        expect_any_instance_of(described_class).to receive(:delete).with('')

        subject
      end
    end

    describe '#update' do
      let(:params) { { email: 'test@test.com', first_name: 'test' } }
      let(:response) { "{\"new_count\":1,\"updated_count\":0,\"error_count\":0,\"error_indices\":[],\"unmodified_indices\":[],\"persisted_recipients\":[\"c2VhbkB0ZXN0LmNvbQ==\"],\"errors\":[]}\n" }
      subject { contact.update(params) }

      before do
        allow_any_instance_of(described_class).to receive(:send_request).and_return(response)
      end

      it 'will call send_request with expect params' do
        expect_any_instance_of(described_class).to receive(:send_request).with(:patch, end_point, [params].to_json)

        subject
      end

      context 'when success' do
        let(:response) { "{\"new_count\":1,\"updated_count\":0,\"error_count\":0,\"error_indices\":[],\"unmodified_indices\":[],\"persisted_recipients\":[\"c2VhbkB0ZXN0LmNvbQ==\"],\"errors\":[]}\n" }

        it { is_expected.to be_nil }
      end

      context 'when failed' do
        let(:response) { "{\"new_count\":0,\"updated_count\":0,\"error_count\":1,\"error_indices\":[0],\"unmodified_indices\":[],\"persisted_recipients\":[],\"errors\":[{\"message\":\"The following parameters are not custom fields or reserved fields: [test]\",\"error_indices\":[0]}]}\n" }

        it 'raise error' do
          expect { subject }.to raise_error Errors::Contact
        end
      end
    end

    describe '#delete' do
      let(:delete_url) { "#{end_point}/1" }
      subject { contact.delete('test@test.com') }

      context 'when found recipient id from sendgrid ' do
        before do
          allow_any_instance_of(described_class).to receive(:send_request)
          allow_any_instance_of(described_class).to receive(:get_recipient_id_by).and_return(1)
        end

        it 'will call send_request with expect params' do
          expect_any_instance_of(described_class).to receive(:send_request).with(:delete, delete_url)

          subject
        end
      end
      context 'when did not found id' do
        before do
          allow_any_instance_of(described_class).to receive(:get_recipient_id_by).and_return(nil)
        end

        it 'will not call send_request with expect params' do
          expect_any_instance_of(described_class).to_not receive(:send_request).with(:delete, delete_url)

          subject
        end
      end
    end

    describe '.search' do
      let(:email) { 'test@test.com' }
      let(:expected_params) { { params: { email: email } } }
      let(:search_url) { "#{end_point}/search" }
      subject { contact.search('test@test.com') }

      before do
        allow_any_instance_of(described_class).to receive(:send_request)
      end

      it 'call send_request with expect params ' do
        expect_any_instance_of(described_class).to receive(:send_request).with(:get, search_url, expected_params)

        subject
      end
    end

    describe '.get_recipient_id_by' do
      subject { contact.send(:get_recipient_id_by, 'test@test.com') }
      before do
        allow_any_instance_of(described_class).to receive(:search).and_return(response)
      end

      context 'found recipient from sendgrid' do
        let(:recipient_id) { 'c2VhbkB0ZXN0LmNvbQ==' }
        let(:response) { "{\"recipient_count\":1,\"recipients\":[{\"id\":\"#{recipient_id}\",\"email\":\"test@test.com\",\"created_at\":1522468445,\"updated_at\":1522469072,\"last_emailed\":null,\"last_clicked\":null,\"last_opened\":null}]}\n" }

        it 'return recipient id' do
          expect(subject).to eq recipient_id
        end
      end

      context 'did not found recipient from sendgrid' do
        let(:response) { "{\"recipient_count\":0,\"recipients\":[]}\n" }

        it 'return recipient id' do
          expect(subject).to be_nil
        end
      end
    end
  end
end
