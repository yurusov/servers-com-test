# frozen_string_literal: true

RSpec.describe 'GET /statistics/:ip_address', type: %i[request database] do
  let(:ip_address) { Factory[:ip_address].value }
  let(:statistics) { app['persistence.rom'].relations[:statistics] }
  let(:request_headers) do
    { 'HTTP_ACCEPT' => 'application/json', 'CONTENT_TYPE' => 'application/json' }
  end

  context 'with right params' do
    before do
      Factory[:statistics, ip_address:, start_time: (DateTime.now - 1), rtt: 100]
      Factory[:statistics, ip_address:, start_time: (DateTime.now - 2), rtt: 150]
      Factory[:statistics, ip_address:, start_time: (DateTime.now - 3), rtt: 50]
      Factory[:statistics, :failed, ip_address:, start_time: (DateTime.now - 3)]
      get "/statistics/#{ip_address}", params, request_headers
    end

    let(:params) { { from: DateTime.now - 7, to: DateTime.now } }
    let(:data) do
      {
        'ip_address' => ip_address.to_s,
        'rtt_min' => 50,
        'rtt_max' => 150,
        'rtt_avg' => 100,
        'rtt_median' => 100.0,
        'rtt_deviation' => 50.0,
        'packet_loss' => 0.25
      }
    end

    it 'is successful' do
      expect(last_response).to be_successful
    end

    it 'returns json' do
      expect(last_response.content_type).to eq('application/json; charset=utf-8')
    end

    it 'returns hash of statistics data' do
      response_body = JSON.parse(last_response.body)
      expect(response_body).to be_a Hash
    end

    it 'returns right data' do
      response_body = JSON.parse(last_response.body)
      ap response_body
      expect(response_body).to eq(data)
    end
  end

  context 'when stats are empty' do
    before { get "/statistics/#{ip_address}", params, request_headers }

    let(:params) { { from: DateTime.now - 7, to: DateTime.now } }

    it 'is returns 404' do
      expect(last_response).to be_not_found
    end
  end
end
