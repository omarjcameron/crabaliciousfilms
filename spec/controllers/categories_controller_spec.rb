require 'rails_helper'

describe CategoriesController do
  describe 'GET #index' do
    before(:each) do
      get :index      
    end

    it 'responds with status code 200' do
      expect(response).to have_http_status 200
    end

    it 'assigns all categories to @categories' do
      expect(assigns(:categories)).to eq Category.all
    end

    it 'renders the :index template' do
      expect(response).to render_template(:index)
    end  
  end

  describe 'GET #show' do
    before(:each) do
      get :show, params: { id: Category.first.id }      
    end

    it 'responds with status code 200' do
      expect(response).to have_http_status 200
    end

    it 'assigns the correct category to @category' do
      expect(assigns(:category)).to eq Category.first
    end

    it 'renders the :show template' do
      expect(response).to render_template(:show)
    end  
  end  
end
