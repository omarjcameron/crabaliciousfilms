require 'rails_helper'

RSpec.describe 'Routing to ratings', type: :routing do
  it 'routes POST /films/1/ratings to ratings#create' do
    expect(post: '/films/1/ratings').to route_to('ratings#create', film_id: '1')
  end

  it 'routes GET /films/1/ratings/new to ratings#new' do
    expect(get: '/films/1/ratings/new').to route_to('ratings#new', film_id: '1')
  end

  it 'routes GET /films/1/ratings/1/edit to ratings#edit' do
    expect(get: '/films/1/ratings/1/edit').to route_to('ratings#edit', film_id: '1', id: '1')
  end

  it 'routes PATCH /films/1/ratings/1 to ratings#update' do
    expect(patch: '/films/1/ratings/1').to route_to('ratings#update', film_id: '1', id: '1')
  end

  it 'routes PUT /films/1/ratings/1 to ratings#update' do
    expect(put: '/films/1/ratings/1').to route_to('ratings#update', film_id: '1', id: '1')
  end

  it 'routes DELETE /films/1/ratings/1 to ratings#destroy' do
    expect(delete: '/films/1/ratings/1').to route_to('ratings#destroy', film_id: '1', id: '1')
  end
end
