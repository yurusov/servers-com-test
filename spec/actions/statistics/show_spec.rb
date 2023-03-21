# frozen_string_literal: true

RSpec.describe ServersComTest::Actions::Statistics::Show do
  let(:params) { {} }
  let(:action) { described_class.new }

  it 'returns successful response' do
    response = action.call(params)
    expect(response).to be_successful
  end
end
