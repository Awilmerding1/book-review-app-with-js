class ReviewSerializer < ActiveModel::Serializer
  attributes :rating, :content, :book, :user, :genres
  belongs_to :user
  belongs_to :book
  has_many :genres, through: :book
end
