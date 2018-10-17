class ReviewSerializer < ActiveModel::Serializer
  attributes :rating, :content
  belongs_to :user
  belongs_to :book
end
