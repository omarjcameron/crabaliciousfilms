class Category < ApplicationRecord
  has_many :films

  validates_presence_of :name
end
