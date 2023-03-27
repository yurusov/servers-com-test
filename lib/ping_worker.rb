# frozen_string_literal: true

require 'bundler'
require 'bundler/setup'
require 'parallel'
require 'net/ping/icmp'

require_relative '../config/app'
Hanami.boot

class PingWorker
  include ServersComTest::Deps['persistence.rom']

  attr_reader :logger

  def initialize(**args)
    super
    @logger = Hanami.logger
  end

  def run(block: true)
    delay = Hanami.app[:settings][:ping_delay]

    loop do
      commit_result(ping)

      break unless block

      sleep delay
    end
  end

  private

  def ping
    ips = ip_addresses.select(:value).where(enabled: true).to_a # TODO: in batches
    Parallel.map(ips, in_threads: 20) do |ip|
      worker = Net::Ping::ICMP.new(ip[:value].to_string, 0, 1)
      timestamp = DateTime.now

      ip[:value].ipv6? ? worker.ping6 : worker.ping

      serialize_result(worker, timestamp)
    end
  end

  def serialize_result(worker, timestamp)
    duration = (worker.duration * 1000).to_i if worker.duration
    { ip_address: worker.host.to_s, rtt: duration, failed: !worker.exception.nil?, start_time: timestamp }
  end

  def commit_result(result)
    logger.info "Committing result for #{result.size} ips"
    statistics.multi_insert(result)
  end

  def ip_addresses
    rom.relations[:ip_addresses]
  end

  def statistics
    rom.relations[:statistics]
  end
end

PingWorker.new.run(block: false)
