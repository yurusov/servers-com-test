# frozen_string_literal: true

module ServersComTest
  module Persistence
    module Relations
      class IpAddresses < ROM::Relation[:sql]
        schema(:ip_addresses, infer: true)

        use :pagination
        per_page 100
      end
    end
  end
end
