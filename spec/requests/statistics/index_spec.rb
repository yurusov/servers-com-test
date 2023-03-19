# frozen_string_literal: true

RSpec.describe 'GET /statistics', type: %i[request database] do
  let(:ip_addresses) { app['persistence.rom'].relations[:ip_addresses] }

  before do
    get '/ip_addresses'
  end

  it 'is successful' do
    expect(last_response).to be_successful
  end

  it 'returns json' do
    expect(last_response.content_type).to eq('application/json; charset=utf-8')
  end

end
