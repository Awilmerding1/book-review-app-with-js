class AuthorSerializer < ActiveModel::Serializer
  attributes :id, :name, :books
  has_many :books
	has_many :reviews, through: :books
	has_many :users, through: :books
	has_many :genres, through: :books
end
