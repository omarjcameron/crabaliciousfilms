require 'rails_helper'

RSpec.describe 'Routing to films', type: :routing do
  it 'routes POST /films to films#create' do
    expect(post: '/films').to route_to('films#create')
  end

  it 'routes GET /films/new to films#new' do
    expect(get: '/films/new').to route_to('films#new')
  end

  it 'routes GET /films/1 to films#show' do
    expect(get: '/films/1').to route_to('films#show', id: '1')
  end

  it 'routes DELETE /films/1 to films#destroy' do
    expect(delete: '/films/1').to route_to('films#destroy', id: '1')
  end
end
