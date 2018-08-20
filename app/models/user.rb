class User < ActiveRecord::Base
  has_many :reviews
	has_many :books, through: :reviews
	has_many :authors, through: :books
	has_many :genres, through: :books
  validates :name, presence: true
  has_secure_password



end
