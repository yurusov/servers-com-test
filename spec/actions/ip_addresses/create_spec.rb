# frozen_string_literal: true

RSpec.describe ServersComTest::Actions::IpAddresses::Create, type: :database do
  let(:action) { described_class.new }

  context 'with real ip address' do
    let(:params) { { ip_address: '127.0.0.1' } }

    it 'returns successful response' do
      response = action.call(params)
      expect(response).to be_successful
    end
  end

  context 'with wrong params' do
    let(:params) { { ip_address: '127' } }

    it 'returns 422 error' do
      response = action.call(params)
      expect(response).to be_unprocessable
    end
  end
end
