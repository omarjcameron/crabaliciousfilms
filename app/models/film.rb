class Film < ApplicationRecord
  belongs_to :category
  has_many :reviews, dependent: :destroy
  has_many :ratings, dependent: :destroy

  validates_presence_of :title

  scope :most_reviewed, -> { joins(:reviews).group("films.id").order("count(reviews) desc").first }

  scope :most_reviewed_list, -> { joins(:reviews).group("films.id").order("count(reviews) desc") }

  scope :top_five_reviewed, -> { joins(:reviews).group("films.id").order("count(reviews) desc").limit(5) }

  scope :by_category, -> (category) { joins(:category).where("categories.name = ?", category).order("title asc") }

  scope :highest_rated, ->  { all.sort_by(&:average_rating).reverse }

  def average_rating
    if self.ratings.any?
      (self.ratings.reduce(0) { |sum, rating| (sum + rating.stars) } / (self.ratings.count * 1.0)).round(2)
    else
      0
    end
  end
end
