# frozen_string_literal: true

module ServersComTest
  module Persistence
    module Relations
      class Statistics < ROM::Relation[:sql]
        schema(:statistics, infer: true) do
          associations do
            belongs_to :ip_address
          end
        end

        use :pagination
        per_page 100
      end
    end
  end
end
