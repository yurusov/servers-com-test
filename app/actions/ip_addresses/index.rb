# frozen_string_literal: true

module ServersComTest
  module Actions
    module IpAddresses
      class Index < ServersComTest::Action
        def handle(*, response)
          ip_addresses = rom.relations[:ip_addresses]
                            .select(:value, :enabled)
                            .order(:value)
                            .to_a
          response.format = :json
          response.body = ip_addresses.to_json
        end
      end
    end
  end
end
