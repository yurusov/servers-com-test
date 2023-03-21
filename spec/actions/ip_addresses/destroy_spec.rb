# frozen_string_literal: true

RSpec.describe ServersComTest::Actions::IpAddresses::Destroy, type: %i[request database] do
  let(:action) { described_class.new }

  context 'when ip address exists' do
    let(:params) { { ip_address: Factory[:ip_address].value.to_s } }

    it 'returns successful response' do
      response = action.call(params)
      expect(response).to be_successful
    end
  end

  context 'when record does not exist' do
    let(:params) { { ip_address: '127.0.0.1' } }

    it 'returns 404 error' do
      response = action.call(params)
      expect(response).to be_not_found
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
