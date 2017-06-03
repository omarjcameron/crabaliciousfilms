require 'rails_helper'

RSpec.describe 'Routing to the application', type: :routing do
  it 'routes GET / to categories#index' do
    expect(get: '/').to route_to('categories#index')
  end
end
