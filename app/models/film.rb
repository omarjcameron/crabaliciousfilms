class Film < ApplicationRecord
  belongs_to :category
  has_many :reviews, dependent: :destroy
  has_many :ratings, dependent: :destroy

  validates_presence_of :title
end
