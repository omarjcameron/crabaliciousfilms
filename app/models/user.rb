class User < ApplicationRecord
  has_many :ratings
  has_many :reviews
  has_many :reviewed_films, through: :reviews, source: :film
  has_many :rated_films, through: :ratings, source: :film
  has_secure_password
end
