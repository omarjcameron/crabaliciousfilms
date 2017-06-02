require 'rails_helper'

describe SessionsController do
  let(:user) { User.first }

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
        post :create, params: { username: 'Max', password: 'password' }
      end

      it 'responds with status code 302' do
        expect(response).to have_http_status 302
      end

      it 'assigns the correct user to @user' do
        expect(assigns(:user)).to eq user
      end

      it 'authenticates the user' do
        expect(assigns(:user).authenticate('password')).to eq user
      end

      it 'creates a new session' do
        expect(session[:id]).to eq user.id
      end

      it 'redirects to the root_path' do
        expect(response).to redirect_to root_path
      end
    end

    context 'when invalid params are passed' do
      before(:each) do
        post :create, params: { username: 'M', password: '123456' }
      end

      it 'does not find a user' do
        expect(assigns(:user)).to eq nil
      end

      it 'sets error message that login information was not correct' do
        expect(assigns(:errors)).to eq ["Incorrect username or password"]
      end

      it 'does not create a new session' do
        expect(session[:id]).to eq nil
      end

      it 'renders the new template' do
        expect(response).to render_template(:new)
      end
    end
  end

  describe 'DELETE #destroy' do
    it 'responds with status code 302' do
      delete :destroy, params: { id: '1' }
      expect(response).to have_http_status 302
    end

    it 'destroys the requested session' do
       session[:id] = '1'
       delete :destroy, params: { id: '1' }
       expect(session[:id]).to eq nil
    end

    it 'redirects to the root path' do
      delete :destroy, params: { id: '1' }
      expect(response).to redirect_to root_path
    end
  end
end
