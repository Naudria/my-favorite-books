class Rating < ApplicationRecord
  belongs_to :user
  belongs_to :book


  validates_presence_of :stars, :book_id

end
