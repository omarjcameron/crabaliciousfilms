require 'rails_helper'

RSpec.describe Category, type: :model do
  let(:category) { Category.new(name: 'Action') }

  describe 'validations' do
    it 'is valid with valid attributes' do
      expect(category).to be_valid
    end

    it 'is not valid without a name' do
      category.name = ''
      expect(category).to_not be_valid
    end
  end

  describe 'associations' do
    it { should have_many(:films) }
  end
end
