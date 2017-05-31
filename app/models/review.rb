class Review < ApplicationRecord
  belongs_to :user
  belongs_to :film

  has_many :comments
  validates_presence_of :title, :body
end
