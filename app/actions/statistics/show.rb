# frozen_string_literal: true

module ServersComTest
  module Actions
    module Statistics
      class Show < ServersComTest::Action
        params do
          required(:ip_address).value(:string,
                                      format?: Regexp.union(IPAddr::RE_IPV4ADDRLIKE, IPAddr::RE_IPV6ADDRLIKE_FULL))
          required(:from).value(:date_time)
          required(:to).value(:date_time)
        end

        def handle(request, response) # rubocop:disable Metrics/AbcSize
          halt 422, { errors: request.params.errors }.to_json unless request.params.valid?

          resources = rom
                      .relations[:statistics]
                      .where do
            start_time.in(request.params[:from]..request.params[:to]) & ip_address.is(request.params[:ip_address])
          end

          response.status = 201
          response.body = resources.to_a.to_json
        end
      end
    end
  end
end
