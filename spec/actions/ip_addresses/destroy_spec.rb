# frozen_string_literal: true

RSpec.describe ServersComTest::Actions::IpAddresses::Destroy, type: %i[request database] do
  let(:params) { { ip_address: '127.0.0.1' } }
  let(:action) { described_class.new }

  context 'when ip address exists' do
    before { app['persistence.rom'].relations[:ip_addresses].insert('value' => '127.0.0.1', 'enabled' => true) }

    it 'returns successful response' do
      response = action.call(params)
      expect(response).to be_successful
    end
  end

  context 'when record does not exist' do
    it 'raises 404 error' do
      response = action.call(params)
      expect(response).to be_not_found
    end
  end
end
