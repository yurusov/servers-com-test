# frozen_string_literal: true

module ServersComTest
  module Actions
    module IpAddresses
      class Destroy < ServersComTest::Action
        params do
          required(:ip_address).value(:string,
                                      format?: Regexp.union(IPAddr::RE_IPV4ADDRLIKE, IPAddr::RE_IPV6ADDRLIKE_FULL))
        end

        def handle(request, response)
          halt 422, { errors: request.params.errors }.to_json unless request.params.valid?

          ip_address = request.params[:ip_address]

          resource = rom
                     .relations[:ip_addresses]
                     .by_pk(ip_address)
                     .changeset(:update, { value: ip_address, enabled: false })
                     .commit

          halt 404, { errors: { ip_addresses: ["IP address #{ip_address} not found!"] } }.to_json unless resource

          response.status = 201
          response.body = resource.to_json
        end
      end
    end
  end
end
