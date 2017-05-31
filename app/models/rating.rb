class Rating < ApplicationRecord
  belongs_to :user
  belongs_to :film

  validates_presence_of :stars
end
