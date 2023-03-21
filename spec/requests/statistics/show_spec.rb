# frozen_string_literal: true

RSpec.describe 'GET /statistics/:ip_address', type: %i[request database] do
  let(:ip_address) { Factory[:ip_address].value }
  let(:request_headers) do
    { 'HTTP_ACCEPT' => 'application/json', 'CONTENT_TYPE' => 'application/json' }
  end

  before do
    10.times { Factory[:statistics, ip_address:] }
    get "/statistics/#{ip_address}", params, request_headers
  end

  context 'with right params' do
    let(:statistics) { app['persistence.rom'].relations[:statistics] }
    let(:params) { { from: DateTime.now - 2, to: DateTime.now } }

    it 'is successful' do
      expect(last_response).to be_successful
    end

    it 'returns json' do
      expect(last_response.content_type).to eq('application/json; charset=utf-8')
    end

    it 'returns array of statistics data' do
      response_body = JSON.parse(last_response.body)
      expect(response_body).to be_a Array
    end

    it 'returns existing data' do
      response_body = JSON.parse(last_response.body)
      sample = statistics.select.where(ip_address: ip_address.to_s).first.transform_keys!(&:to_s)
      sample['ip_address'] = sample['ip_address'].to_s
      sample['start_time'] = sample['start_time'].to_s

      expect(response_body).to include(sample)
    end
  end
end
