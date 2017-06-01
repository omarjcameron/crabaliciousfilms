class User < ApplicationRecord
  has_many :ratings
  has_many :reviews
  has_many :reviewed_films, through: :reviews, source: :film
  has_many :rated_films, through: :ratings, source: :film
  has_many :comments
  
  has_secure_password

  validates_presence_of :username, :email
  validates_uniqueness_of :username, :email
  validates :password, length: { minimum: 6 }

  def review_for_film(film)
    self.reviews.where(film: film)
  end

  def rating_for_film(film)
    self.ratings.where(film: film)
  end

  def reviewed_and_rated_films
    (reviewed_films + rated_films).uniq
  end
end
