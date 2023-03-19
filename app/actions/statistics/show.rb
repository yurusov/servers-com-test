# frozen_string_literal: true

module ServersComTest
  module Actions
    module Statistics
      class Show < ServersComTest::Action
        def handle(*, response)
          response.body = self.class.name
        end
      end
    end
  end
end
