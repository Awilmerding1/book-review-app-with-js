class Author < ActiveRecord::Base
  Has_many :books
	Has_many :reviews, through: :books
	Has_many :users, through: :books
	Has_many :genres, through: :books

end
