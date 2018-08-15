class Book < ApplicationRecord
  Belongs_to :author
	Has_many :book_genres
	Has_many :genres, through: :book_genres
	Has_many :reviews
	Has_many :users, through: :reviews

end
