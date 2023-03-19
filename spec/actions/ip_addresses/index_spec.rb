# frozen_string_literal: true

RSpec.describe ServersComTest::Actions::IpAddresses::Index do
  let(:params) { Hash[] }
  let(:action) { described_class.new }

  it 'returns successful response' do
    response = action.call(params)
    expect(response).to be_successful
  end
end
