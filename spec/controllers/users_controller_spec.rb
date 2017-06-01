require 'rails_helper'

describe UsersController do
  let(:user) { User.first }

  describe 'GET #show' do
    it 'responds with status code 200' do
      get :show, params: { id: user.id }
      expect(response).to have_http_status 200
    end

    it 'assigns the correct user to @user' do
      get :show, params: { id: user.id }
      expect(assigns(:user)).to eq user
    end

    it 'renders the :show template' do
      get :show, params: { id: user.id }
      expect(response).to render_template(:show)
    end  
  end  

  describe 'GET #new' do
    before(:each) do
      get :new
    end

    it 'responds with status code 200' do
      expect(response).to have_http_status 200
    end

    it 'assigns a new user to @user' do
      expect(assigns(:user)).to be_a_new User
    end

    it 'renders the new template' do
      expect(response).to render_template(:new)
    end
  end

  describe 'POST #create' do
    context 'when valid params are passed' do
      before(:each) do
        post :create, params: { user: { username: 'Example', email: 'example@test.com', password: 'password' } }
      end

      it 'responds with status code 302' do
        expect(response).to have_http_status 302
      end

      it 'creates a new user in the database' do
        expect(User.last.username).to eq 'Example'
      end

      it 'assigns the newly created user as @user' do
        expect(assigns(:user)).to eq User.last
      end

      it 'creates a new session' do
        expect(session[:id]).to eq User.last.id
      end

      it 'redirects to the root_path' do
        expect(response).to redirect_to root_path
      end
    end

    context 'when invalid params are passed' do
      before(:each) do
        post :create, params: { user: { username: 'Example', email: '', password: '123' } }
      end

      it 'does not add a user to the database' do
        expect(assigns(User.last.username)).to_not eq 'Example'
      end

      it 'assigns the unsaved user as @user' do
        expect(assigns(:user)).to be_a_new User
      end

      it 'does not create a new session' do
        expect(session[:id]).to eq nil
      end

      it 'renders the new template' do
        expect(response).to render_template(:new)
      end
    end
  end
end
