# frozen_string_literal: true

module ServersComTest
  class Routes < Hanami::Routes
    get '/statistics/:ip_address', to: 'statistics.show'
    get '/ip_addresses', to: 'ip_addresses.index'
    post '/ip_addresses/:ip_address', to: 'ip_addresses.create'
    delete '/ip_addresses/:ip_address', to: 'ip_addresses.destroy'
  end
end
