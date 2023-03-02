class Post < ApplicationRecord
  has_many :images, dependent: :destroy
  belongs_to :user  # アソシエーション
  has_many :favorites, dependent: :destroy

  def favorite?(user)
    favorites.where(user_id: user.id).exists?
  end
end
