class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :omniauthable, omniauth_providers: [:facebook, :github, :google_oauth2, :twitter2]

  has_many :posts
  has_many :likes
  has_many :comments

  has_many :followed_users, foreign_key: :follower_id, class_name: "Follow"
  has_many :followees, through: :followed_users

  has_many :following_users, foreign_key: :followee_id, class_name: "Follow"
  has_many :followers, through: :following_users
end
