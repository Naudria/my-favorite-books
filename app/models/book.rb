class Book < ApplicationRecord
  has_many :ratings
  has_many :users, through: :ratings

  validates_presence_of :title, :author, :genre
  validates_uniqueness_of :title
end
