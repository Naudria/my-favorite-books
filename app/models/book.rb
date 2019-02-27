class Book < ApplicationRecord
  has_many :ratings
  has_many :users, through: :ratings

  validates_presence_of :title, :author, :genre
  validates_uniqueness_of :title


  # Scope methods

  def self.popular
    joins(:ratings).group('books.id').having('COUNT(*) > 3').select('books.*')

  end

  def average_rating
    Rating.where(book_id: self.id).average(:stars).to_i
  end

  def total_ratings
    Rating.where(book_id: self.id).count(:stars).to_i
  end

end
