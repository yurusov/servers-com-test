# frozen_string_literal: true

require_relative '../../lib/ping_worker'

RSpec.describe PingWorker, type: :database do
  let(:run) { described_class.new.run(block: false) }
  let(:statistics) { Hanami.app['persistence.rom'].relations[:statistics] }

  before { ip_address }

  context 'with ipv4 addresses' do
    let(:ip_address) { Factory[:ip_address, value: '127.0.0.1'][:value].to_s }

    it 'runs' do
      expect { run }.not_to raise_error
    end

    it 'creates statistics' do
      run
      expect(statistics.select(:ip_address, :failed).where(ip_address:).first).to eq({ ip_address:, failed: false })
    end
  end

  context 'with ipv6 addresses' do
    let(:ip_address) { Factory[:ip_address, value: '::1'][:value].to_s }

    it 'runs' do
      expect { run }.not_to raise_error
    end

    it 'creates statistics' do
      run
      expect(statistics.select(:ip_address, :failed).where(ip_address:).first).to eq({ ip_address:, failed: false })
    end
  end
end
