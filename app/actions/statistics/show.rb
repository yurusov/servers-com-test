# frozen_string_literal: true

module ServersComTest
  module Actions
    module Statistics
      class Show < ServersComTest::Action
        params do
          required(:ip_address).value(:string, # TODO: custom type validation
                                      format?: Regexp.union(IPAddr::RE_IPV4ADDRLIKE, IPAddr::RE_IPV6ADDRLIKE_FULL))
          required(:from).value(:date_time)
          required(:to).value(:date_time)
        end

        def handle(request, response)
          halt 422, { errors: request.params.errors }.to_json unless request.params.valid?

          resources = scope(request.params[:ip_address], (request.params[:from]..request.params[:to]))

          halt 404, { errors: { statistics: :not_found } } if resources.empty?

          response.status = 201
          response.body = serialize(resources).to_json
        end

        private

        def scope(ip, range)
          rom
            .relations[:statistics]
            .select(:ip_address, :rtt, :failed)
            .where { start_time.in(range) & ip_address.is(ip) }
            .to_a
        end

        def serialize(resources)
          rtt = resources.map { |r| r[:rtt] }.delete_if(&:zero?)

          {
            ip_address: resources.first[:ip_address],
            rtt_min: rtt.min,
            rtt_max: rtt.max,
            rtt_avg: mean(rtt),
            rtt_median: median(rtt),
            rtt_deviation: std_dev(rtt),
            packet_loss: resources.count { |r| r[:failed] } / resources.size.to_f
          }
        end

        def mean(arr)
          arr.reduce(&:+) / arr.size
        end

        def median(arr)
          sorted = arr.sort
          (sorted[(arr.size - 1) / 2] + sorted[arr.size / 2]) / 2.0
        end

        def std_dev(arr)
          sum_sqr = arr.map { |x| x * x }.reduce(&:+)
          Math.sqrt((sum_sqr - (arr.size * mean(arr) * mean(arr))) / (arr.size - 1))
        end
      end
    end
  end
end
