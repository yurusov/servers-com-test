# frozen_string_literal: true

RSpec.describe 'DELETE /ip_addresses', type: %i[request database] do
  let(:ip_addresses) { app['persistence.rom'].relations[:ip_addresses] }
  let(:ipv4_addr) { { 'value' => '127.0.0.1', 'enabled' => true } }
  let(:ipv6_addr) { { 'value' => '::1', 'enabled' => false } }

  before do
    ip_addresses.insert(ipv4_addr)
    ip_addresses.insert(ipv6_addr)
    delete "/ip_addresses/#{ip_addr}"
  end

  context 'with ipv4' do
    let(:ip_addr) { ipv4_addr['value'] }

    it 'is successfully deleted' do
      expect(last_response).to be_successful
    end

    it 'returns json' do
      expect(last_response.content_type).to eq('application/json; charset=utf-8')
    end

    it 'returns disabled ip address' do
      response_body = JSON.parse(last_response.body)
      expect(response_body).to eq({ value: ip_addr, enabled: false })
    end
  end
end
