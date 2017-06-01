require 'rails_helper'

RSpec.describe Review, type: :model do
  let(:review) { Review.new(title: 'Good Movie', body: 'This was a fantastic film',
                            user_id: User.last.id, film_id: Film.first.id) }

  describe 'validations' do
    it 'is valid with valid attributes' do
      expect(review).to be_valid
    end

    it 'is not valid without a title' do
      review.title = ''
      expect(review).to_not be_valid
    end

    it 'is not valid without a body' do
      review.body = ''
      expect(review).to_not be_valid
    end

    it 'is not valid without a user' do
      review.user = nil
      expect(review).to_not be_valid
    end


    it 'is not valid without a film' do
      review.film = nil
      expect(review).to_not be_valid
    end
  end

  describe 'associations' do
    it { should belong_to(:user) }
    it { should belong_to(:film) }
    it { should have_many(:comments) }
  end
end
