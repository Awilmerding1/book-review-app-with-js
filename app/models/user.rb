class User < ActiveRecord::Base
  Has_many :reviews
	Has_many :books, through: :reviews
	Has_many :authors, through: :books
	Has_many :genres, through: :books
  has_secure_password

end
