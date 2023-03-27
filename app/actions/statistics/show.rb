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

          result = scope(request.params[:ip_address], (request.params[:from]..request.params[:to]))

          halt 404, { errors: { statistics: :not_found } } unless result

          response.status = 201
          response.body = result.to_json
        end

        private

        def relation # rubocop:disable Metrics/AbcSize
          rom.relations[:statistics].select do
            [
              ip_address, integer.max(rtt).as(:rtt_max), integer.min(rtt).as(:rtt_min),
              float.cast(integer.avg(rtt)).as(:rtt_avg), float.cast(integer.stddev_samp(rtt)).as(:rtt_deviation),
              float.cast(integer.percentile_cont(0.5).within_group(rtt)).as(:rtt_median),
              (
                (float.cast(integer.count(bool.case(failed => 1, else: nil))) / float.cast(integer.count(id)))
              ).as(:packet_loss)
            ]
          end
        end

        def scope(ip, range)
          relation
            .group(:ip_address).order(:ip_address)
            .where { start_time.in(range) & ip_address.is(ip) }
            .to_a
            .first
        end
      end
    end
  end
end
