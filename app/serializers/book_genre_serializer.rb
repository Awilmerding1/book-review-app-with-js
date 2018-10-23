class BookGenreSerializer < ActiveModel::Serializer
  attributes :id, :book, :genre
  belongs_to :book, serializer: GenreSerializer
  belongs_to :genre, serializer: BookSerializer
end
