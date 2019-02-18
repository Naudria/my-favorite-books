class User < ApplicationRecord
  has_many :ratings
  has_many :books, through: :ratings

  has_secure_password
  # A method that uses Bcrypt to hash passwords
  validates_presence_of :name, :email
  validates_uniqueness_of :name, :email
end
