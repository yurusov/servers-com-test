# frozen_string_literal: true

RSpec.describe 'DELETE /ip_addresses/:ip_address', type: %i[request database] do
  let(:request_headers) do
    { 'HTTP_ACCEPT' => 'application/json', 'CONTENT_TYPE' => 'application/json' }
  end

  before do
    delete "/ip_addresses/#{ip_address.value}", {}.to_json, request_headers
  end

  context 'with ipv4' do
    let(:ip_address) { Factory[:ip_address] }

    it 'is successfully deleted' do
      expect(last_response).to be_successful
    end

    it 'returns json' do
      expect(last_response.content_type).to eq('application/json; charset=utf-8')
    end

    it 'returns disabled ip address' do
      response_body = JSON.parse(last_response.body)
      expect(response_body).to eq({ 'value' => ip_address.value.to_s, 'enabled' => false })
    end
  end

  context 'with ipv6' do
    let(:ip_address) { Factory[:ip_address, :ipv6] }

    it 'is successfully deleted' do
      expect(last_response).to be_successful
    end

    it 'returns json' do
      expect(last_response.content_type).to eq('application/json; charset=utf-8')
    end

    it 'returns disabled ip address' do
      response_body = JSON.parse(last_response.body)
      expect(response_body).to eq({ 'value' => ip_address.value.to_s, 'enabled' => false })
    end
  end
end
