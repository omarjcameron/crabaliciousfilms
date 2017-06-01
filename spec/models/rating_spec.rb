require 'rails_helper'

RSpec.describe Rating, type: :model do
  let(:rating) { Rating.new(stars: 4, user_id: User.first.id, film_id: Film.last.id) }

  describe 'validations' do
    it 'is valid with valid attributes' do
      expect(rating).to be_valid
    end

    it 'is not valid without stars' do
      rating.stars = nil
      expect(rating).to_not be_valid
    end

    it 'is not valid without a user' do
      rating.user = nil
      expect(rating).to_not be_valid
    end

    it 'is not valid without a film' do
      rating.film = nil
      expect(rating).to_not be_valid
    end
  end

  describe 'associations' do
    
  end
end
