class Film < ApplicationRecord
  belongs_to :category
  has_many :reviews
  has_many :ratings

  validates_presence_of :title
end
