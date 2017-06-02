require 'rails_helper'

RSpec.describe User, type: :model do
  let(:user) { User.new(username: 'username', email: 'email@email.com', password: 'tomtom') }

  describe 'validations' do
    it 'is valid with valid attributes' do
      expect(user).to be_valid
    end

    it 'is not valid without a username' do
      user.username = ''
      expect(user).to_not be_valid
    end  

    it 'is not valid without an email' do
      user.email = ''
      expect(user).to_not be_valid
    end

    it 'is not valid without a password of at least 6 characters' do
      user.password = 'tom'
      expect(user).to_not be_valid
    end

    it 'is not valid without a unique username' do
      user.username = 'Max'
      expect(user).to_not be_valid
    end

    it 'is not valid without a unique email' do
      user.email = 'max@test.com'
      expect(user).to_not be_valid      
    end
  end

  describe 'associations' do
    it { should have_many(:ratings) }
    it { should have_many(:reviews) }
    it { should have_many(:reviewed_films) }
    it { should have_many(:rated_films) }
    it { should have_many(:comments) }
  end
end
