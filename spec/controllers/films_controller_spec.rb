require 'rails_helper'

describe FilmsController do
  describe 'POST #create' do
    context 'when valid params are passed' do
      it 'responds with status code 302' do
        post :create, params: { film: { title: 'Donnie Darko', category: 'Thriller' } }
        expect(response).to have_http_status 302
      end

      it 'creates a new film in the database' do
        expect { post(:create, params: { film: { title: 'Donnie Darko', category: 'Thriller' } }) }.to change(Film, :count).by(1)
      end

      it 'assigns the newly created film as @film' do
        post :create, params: { film: { title: 'Donnie Darko', category: 'Thriller' } }
        expect(assigns(:film)).to eq Film.last
      end

      it 'redirects to the category page of the newly created film' do
        post :create, params: { film: { title: 'Donnie Darko', category: 'Thriller' } }
        expect(response).to redirect_to category_path(Film.last.category)
      end
    end

    context 'when invalid params are passed' do
      it 'sets error message that film was not created' do
        post :create, params: { film: { title: '', category: 'Thriller' } }
        expect(flash[:errors][0]).to eq "Title can't be blank"
      end

      it 'does not create a new film in the database' do
        expect { post(:create, params: { film: { title: '', category: 'Thriller' } }) }.to change(Film, :count).by(0)
      end

      it 'assigns the unsaved film as @film' do
        post :create, params: { film: { title: '', category: 'Thriller' } }
        expect(assigns(:film)).to be_a_new Film
      end

      it 'redirects to the new film path' do
        post :create, params: { film: { title: '', category: 'Thriller' } }
        expect(response).to redirect_to new_film_path
      end
    end
  end

  describe 'GET #new' do
    before(:each) do
      session[:id] = '1'
    end
    
    it 'responds with status code 200' do
      get :new
      expect(response).to have_http_status 200
    end

    it 'assigns a new film to @film' do
      get :new
      expect(assigns(:film)).to be_a_new Film
    end

    it 'renders the new template' do
      get :new
      expect(response).to render_template(:new)
    end
  end

  describe 'GET #show' do
    it 'responds with status code 200' do
      get :show, params: { id: Film.first.id }
      expect(response).to have_http_status 200
    end

    it 'assigns the correct film to @film' do
      get :show, params: { id: Film.first.id }
      expect(assigns(:film)).to eq Film.first
    end

    it 'renders the :show template' do
      get :show, params: { id: Film.first.id }
      expect(response).to render_template(:show)
    end  
  end  

  describe 'DELETE #destroy' do
    it 'responds with status code 302' do
      delete :destroy, params: { id: Film.last.id }
      expect(response).to have_http_status 302
    end

    it 'destroys the requested film' do
      expect { delete(:destroy, params: { id: Film.last.id }) }.to change(Film, :count).by(-1)
    end

    it 'redirects to the root path' do
      delete :destroy, params: { id: Film.last.id }
      expect(response).to redirect_to root_path
    end
  end
end
