class User < ApplicationRecord
  has_many :ratings
  has_many :reviews
  has_many :reviewed_films, through: :reviews, source: :film
  has_many :rated_films, through: :ratings, source: :film
  has_many :comments

  has_secure_password

  validates_presence_of :username, :email
  validates_uniqueness_of :username, :email
  validates :password, length: {minimum: 6}
  validates :authorize_count, numericality: {equal_to: 0}, unless: :trusted
  validates :authorize_count, numericality: {greater_than_or_equal_to: 0, less_than: 5}, if: :trusted

  scope :non_trusted, -> { where(trusted: false) }
  scope :trusted, -> { where(trusted: true) }

  def review_for_film(film)
    self.reviews.where(film: film)
  end

  def rating_for_film(film)
    self.ratings.where(film: film)
  end

  def reviewed_and_rated_films
    (reviewed_films + rated_films).uniq
  end

  def password
    @password ||= BCrypt::Password.new(password_digest)
  end
end
