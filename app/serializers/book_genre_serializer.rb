class BookGenreSerializer < ActiveModel::Serializer
  attributes :id
  belongs_to :book
  belongs_to :genre
end
