class Genre < ActiveRecord::Base
  Has_many :book_genres
	Has_many :books, through: :book_genres
	Has_many :authors, through: :books

end
