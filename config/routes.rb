# frozen_string_literal: true

module ServersComTest
  class Routes < Hanami::Routes
    scope 'ip_addresses' do
      get '/', to: 'ip_addresses.index'
      post '/:ip_address', to: 'ip_addresses.create'
      delete '/:ip_address', to: 'ip_addresses.destroy'
    end

    get '/statistics/:ip_address', to: 'statistics.show'
  end
end
