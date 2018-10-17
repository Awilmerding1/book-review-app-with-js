class ReviewSerializer < ActiveModel::Serializer
  attributes :rating, :content
  belongs_to :user, :book
end
