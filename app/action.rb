# auto_register: false
# frozen_string_literal: true

require 'hanami/action'

module ServersComTest
  class Action < Hanami::Action
    include Deps['persistence.rom']

    handle_exception IPAddr::InvalidAddressError => 422
    handle_exception StandardError => :handle_standard_error

    private

    def handle_standard_error(_request, response, exception)
      response.status = 500
      response.body = { errors: { actions: [exception.message] } }.to_json
    end
  end
end
