require 'rails_helper'

RSpec.describe Comment, type: :model do
  let(:comment) { Comment.new(content: 'I am a comment',
                              user_id: User.first.id, 
                              review_id: Review.first.id) }

  describe 'validations' do
    it 'is valid with valid attributes' do
      expect(comment).to be_valid
    end

    it 'is not valid without content' do
      comment.content = ''
      expect(comment).to_not be_valid
    end

    it 'is not valid without a user id' do
      comment.user_id = nil
      expect(comment).to_not be_valid
    end

    it 'is not valid with a review id' do
      comment.review_id = nil
      expect(comment).to_not be_valid
    end
  end
end
