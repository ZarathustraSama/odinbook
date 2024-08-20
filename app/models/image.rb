class Image < ApplicationRecord
  has_many :posts, as: :postable
end
