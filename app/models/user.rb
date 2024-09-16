class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :omniauthable, omniauth_providers: [:google_oauth2]

  has_many :posts, dependent: :destroy
  has_many :likes, dependent: :destroy
  has_many :comments, dependent: :destroy

  has_many :followed_users, foreign_key: :follower_id, class_name: "Follow", dependent: :destroy
  has_many :followees, through: :followed_users

  has_many :following_users, foreign_key: :followee_id, class_name: "Follow", dependent: :destroy
  has_many :followers, through: :following_users

  validates_presence_of(:name)

  # As per documentation here: https://github.com/zquestz/omniauth-google-oauth2?tab=readme-ov-file#devise

  def self.from_omniauth(access_token)
    data = access_token.info
    user = User.where(email: data['email']).first

    unless user
        user = User.create(name: data['name'],
           email: data['email'],
           password: Devise.friendly_token[0,20],
           provider: access_token.provider,
           uid: access_token.uid,
           photo_url: data['image']
        )
    end
    user
  end
end
