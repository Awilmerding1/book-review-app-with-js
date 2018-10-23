class GenreSerializer < ActiveModel::Serializer
  attributes :id, :name
  has_many :book_genres
	has_many :books, through: :book_genres
	has_many :authors, through: :books

end
