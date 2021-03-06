class UserSerializer < ActiveModel::Serializer
  attributes :id, :name, :reviews, :books
  has_many :reviews
	has_many :books, through: :reviews
	has_many :authors, through: :books
  has_many :genres, through: :books
end
