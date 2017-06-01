class Review < ApplicationRecord
  belongs_to :user
  belongs_to :film
  has_many :comments, dependent: :destroy
  
  validates_presence_of :title, :body
end
