require 'rails_helper'

describe CategoriesController do
  describe 'GET #index' do
    it 'responds with status code 200' do
      get :index
      expect(response).to have_http_status 200
    end

    it 'assigns all categories to @categories' do
      get :index
      expect(assigns(:categories)).to eq Category.all
    end

    it 'renders the :index template' do
      get :index
      expect(response).to render_template(:index)
    end  
  end

  describe 'GET #show' do
    it 'responds with status code 200' do
      get :show, params: { id: Category.first.id }
      expect(response).to have_http_status 200
    end

    it 'assigns the correct category to @category' do
      get :show, params: { id: Category.first.id }
      expect(assigns(:category)).to eq Category.first
    end

    it 'renders the :show template' do
      get :show, params: { id: Category.first.id }
      expect(response).to render_template(:show)
    end  
  end  
end
