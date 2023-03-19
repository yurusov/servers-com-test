# frozen_string_literal: true

RSpec.describe 'POST /ip_addresses', type: %i[request database] do
  let(:ip_addresses) { app['persistence.rom'].relations[:ip_addresses] }
  let(:request_headers) do
    { 'HTTP_ACCEPT' => 'application/json', 'CONTENT_TYPE' => 'application/json' }
  end

  before do
    post "/ip_addresses/#{ip_address}", {}.to_json, request_headers
  end

  context 'with ipv4 address' do
    let(:ip_address) { '127.0.0.1' }

    it 'is successfully created' do
      expect(last_response).to be_created
    end

    it 'returns json' do
      expect(last_response.content_type).to eq('application/json; charset=utf-8')
    end

    it 'returns created object' do
      expect(last_response.body).to eq(ip_addresses.select.one.to_json)
    end
  end

  context 'with ipv6 address' do
    let(:ip_address) { '0:0:0:0:0:0:0:1' }

    it 'is successfully created' do
      expect(last_response).to be_created
    end

    it 'returns json' do
      expect(last_response.content_type).to eq('application/json; charset=utf-8')
    end

    it 'returns created object' do
      expect(last_response.body).to eq(ip_addresses.select.one.to_json)
    end
  end

  context 'with invalid params' do
    let(:ip_address) { 123412 }

    it 'returns 422 unprocessable' do
      expect(last_response).to be_unprocessable
    end
  end

  context 'with invalid ip' do
    let(:ip_address) { '127.0.0.1337' }

    it 'returns 500 error' do
      expect(last_response).to be_server_error
    end
  end
end
