require 'rails_helper'

describe FilmsController do
  describe 'GET #index' do
    context 'when no filter params are passed' do
      before(:each) do
        get :index
      end

      it 'responds with status code 200' do
        expect(response).to have_http_status 200
      end

      it 'assigns all categories to @categories' do
        expect(assigns(:films)).to eq Film.all
      end

      it 'renders the :index template' do
        expect(response).to render_template(:index)
      end
    end

    context 'when filter params are passed' do
      it 'filters highest rated films' do
        get :index, params: { filter: 'Highest Rated' }
        expect(assigns(:films)).to eq Film.highest_rated
      end

      it 'filters top 5 rated films' do
        get :index, params: { filter: 'Top 5 Rated' }
        expect(assigns(:films)).to eq Film.top_five_rated
      end

      it 'filters most reviewed films' do
        get :index, params: { filter: 'Most Reviewed' }
        expect(assigns(:films)).to eq Film.most_reviewed_list
      end

      it 'filters top 5 reviewed films' do
        get :index, params: { filter: 'Top 5 Reviewed' }
        expect(assigns(:films)).to eq Film.top_five_reviewed
      end

      it 'filters all films' do
        get :index, params: { filter: 'All Films' }
        expect(assigns(:films)).to eq Film.all
      end

      it 'filters by category' do
        get :index, params: { filter: 'Comedy' }
        expect(assigns(:films)).to eq Film.by_category('Comedy')         
      end
    end
  end

  describe 'POST #create' do
    context 'when valid params are passed' do
      before(:each) do |test|
        post :create, params: { film: { title: 'Donnie Darko', category: 'Thriller' } } unless test.metadata[:has_request]        
      end

      it 'responds with status code 302' do
        expect(response).to have_http_status 302
      end

      it 'creates a new film in the database', :has_request do
        expect { post(:create, params: { film: { title: 'Donnie Darko', category: 'Thriller' } }) }.to change(Film, :count).by(1)
      end

      it 'assigns the newly created film as @film' do
        expect(assigns(:film)).to eq Film.last
      end

      it 'redirects to the category page of the newly created film' do
        expect(response).to redirect_to category_path(Film.last.category)
      end
    end

    context 'when invalid params are passed' do
      before(:each) do |test|
        post :create, params: { film: { title: '', category: 'Thriller' } } unless test.metadata[:has_request]                
      end

      it 'responds with status code 500', :has_request do
        post :create, xhr: true, params: { film: { title: '', category: 'Thriller' } }
        expect(response).to have_http_status 500
      end

      it 'does not create a new film in the database', :has_request do
        expect { post(:create, params: { film: { title: '', category: 'Thriller' } }) }.to change(Film, :count).by(0)
      end

      it 'assigns the unsaved film as @film' do
        expect(assigns(:film)).to be_a_new Film
      end

      it 'renders the new template' do
        expect(response).to render_template(:new)
      end
    end
  end

  describe 'GET #new' do
    before(:each) do
      session[:id] = '1'
      get :new
    end
    
    it 'responds with status code 302' do
      expect(response).to have_http_status 302
    end

    it 'assigns a new film to @film' do
      expect(assigns(:film)).to be_a_new Film
    end

    it 'redirects to the new template' do
      expect(response).to redirect_to new_film_path
    end
  end

  describe 'GET #show' do
    before(:each) do
      get :show, params: { id: Film.first.id }      
    end

    it 'responds with status code 200' do
      expect(response).to have_http_status 200
    end

    it 'assigns the correct film to @film' do
      expect(assigns(:film)).to eq Film.first
    end

    it 'renders the :show template' do
      expect(response).to render_template(:show)
    end  
  end  

  describe 'DELETE #destroy' do
    before(:each) do |test|
      delete :destroy, params: { id: Film.last.id } unless test.metadata[:has_request]      
    end

    it 'responds with status code 302' do
      expect(response).to have_http_status 302
    end

    it 'destroys the requested film', :has_request do
      expect { delete(:destroy, params: { id: Film.last.id }) }.to change(Film, :count).by(-1)
    end

    it 'redirects to the root path' do
      expect(response).to redirect_to root_path
    end
  end
end
