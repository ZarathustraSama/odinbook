class Post < ApplicationRecord
  belongs_to :postable, polymorphic: true
  belongs_to :user

  has_many :likes
  has_many :comments
end
