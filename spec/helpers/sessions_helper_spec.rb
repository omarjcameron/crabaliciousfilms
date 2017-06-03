require 'rails_helper'

describe SessionsHelper do
  describe 'login' do
    it 'logs in the user' do
      user = User.first
      helper.login(user)
      expect(session[:id]).to eq user.id
    end
  end

  describe 'current_user' do
    context 'a user is logged in' do
      it 'returns the current user' do
        helper.login(User.first)
        expect(helper.current_user).to eq User.first
      end
    end

    context 'a user is not logged in' do
      it 'returns nil' do
        expect(helper.current_user).to eq nil
      end
    end
  end

  describe 'logged_in?' do
    context 'a user is logged in' do
      it 'returns true' do
        helper.login(User.first)
        expect(helper.logged_in?).to eq true
      end
    end

    context 'a user is not logged in' do
      it 'returns false' do
        expect(helper.logged_in?).to eq false
      end
    end
  end

  describe 'logout' do
    it 'logs out the user' do
      helper.login(User.last)
      helper.logout
      expect(session[:id]).to eq nil
    end
  end  
end
