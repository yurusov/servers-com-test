# frozen_string_literal: true

RSpec.describe ServersComTest::Actions::IpAddresses::Create, type: :database do
  let(:params) { { ip_address: '127.0.0.1' } }
  let(:action) { described_class.new }

  it 'returns successful response' do
    response = action.call(params)
    expect(response).to be_successful
  end
end
