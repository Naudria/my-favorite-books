class Book < ApplicationRecord
  has_many :ratings
  has_many :users, through: :ratings

  validates_presence_of :title, :author, :genre
  validates_uniqueness_of :title

  def average_rating
    Rating.where(book_id: self.id).average(:stars).to_i
  end

  def popularity_rating
    self.average_rating + self.ratings.count
  end

  def popular?
    if self.average_rating >= 3
      "#{self.title}" + " " + "#{self.popularity_rating}"
    end
  end

  def self.popularity

    Book.all.sort_by do |book|
      book.average_rating
    end.reverse
  end

end
