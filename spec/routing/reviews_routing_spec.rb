require 'rails_helper'

RSpec.describe 'Routing to reviews', type: :routing do
  it 'routes POST /films/1/reviews to reviews#create' do
    expect(post: '/films/1/reviews').to route_to('reviews#create', film_id: '1')
  end

  it 'routes GET /films/1/reviews/new to reviews#new' do
    expect(get: '/films/1/reviews/new').to route_to('reviews#new', film_id: '1')
  end

  it 'routes GET /films/1/reviews/1/edit to reviews#edit' do
    expect(get: '/films/1/reviews/1/edit').to route_to('reviews#edit', film_id: '1', id: '1')
  end

  it 'routes PATCH /films/1/reviews/1 to reviews#update' do
    expect(patch: '/films/1/reviews/1').to route_to('reviews#update', film_id: '1', id: '1')
  end

  it 'routes PUT /films/1/reviews/1 to reviews#update' do
    expect(put: '/films/1/reviews/1').to route_to('reviews#update', film_id: '1', id: '1')
  end

  it 'routes DELETE /films/1/reviews/1 to reviews#destroy' do
    expect(delete: '/films/1/reviews/1').to route_to('reviews#destroy', film_id: '1', id: '1')
  end
end
