class ReviewSerializer < ActiveModel::Serializer
  attributes :rating, :content, :book, :user
  belongs_to :user
  belongs_to :book
end
