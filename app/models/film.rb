class Film < ApplicationRecord
  belongs_to :category
  has_many :reviews, dependent: :destroy
  has_many :ratings, dependent: :destroy

  validates_presence_of :title

  def average_rating
    ratings.reduce(0) {|accum, rating| accum +rating.stars} / ratings.count
  end
end
