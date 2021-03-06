class BookSerializer < ActiveModel::Serializer
  attributes :id, :title, :reviews, :author, :genres, :users
  belongs_to :author
  has_many :book_genres
  has_many :genres, through: :book_genres
  has_many :reviews
  has_many :users, through: :reviews
end
