class ReviewSerializer < ActiveModel::Serializer
  attributes :rating, :content, :book
  belongs_to :user
  belongs_to :book
end
