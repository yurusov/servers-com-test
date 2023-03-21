# frozen_string_literal: true

module ServersComTest
  module Actions
    module IpAddresses
      class Create < ServersComTest::Action
        params do
          required(:ip_address).value(:string,
                                      format?: Regexp.union(IPAddr::RE_IPV4ADDRLIKE, IPAddr::RE_IPV6ADDRLIKE_FULL))
        end

        def handle(request, response)
          halt 422, { errors: request.params.errors }.to_json unless request.params.valid?

          ip_address = request.params[:ip_address]

          resource = resources.by_pk(ip_address).changeset(:update, { value: ip_address, enabled: true }).commit

          resource ||= resources.changeset(:create, { value: ip_address, enabled: true }).commit

          response.status = 201
          response.body = resource.to_json
        end

        private

        def resources
          rom.relations[:ip_addresses]
        end
      end
    end
  end
end
