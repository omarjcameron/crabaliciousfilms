require 'rails_helper'

RSpec.describe Film, type: :model do
  let(:film) { Film.new(title: 'Superbad', category_id: Category.first.id) }

  describe 'validations' do
    it 'is valid with valid attributes' do
      expect(film).to be_valid
    end

    it 'is not valid without a title' do
      film.title = ''
      expect(film).to_not be_valid
    end

    it 'is not valid without a category' do
      film.category = nil
      expect(film).to_not be_valid
    end
  end

  describe 'associations' do
    it { should belong_to(:category) }
    it { should have_many(:reviews) }
    it { should have_many(:ratings) }
  end
end
