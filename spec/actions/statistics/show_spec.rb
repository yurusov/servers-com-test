# frozen_string_literal: true

RSpec.describe ServersComTest::Actions::Statistics::Show, type: :database do
  let(:action) { described_class.new }

  context 'with correct params' do
    let(:ip_address) { Factory[:ip_address].value.to_s }
    let(:params) { { ip_address:, from: DateTime.now - 2, to: DateTime.now } }

    before do
      10.times { Factory[:statistics, ip_address:] }
    end

    it 'returns successful response' do
      response = action.call(params)
      expect(response).to be_successful
    end
  end
end
