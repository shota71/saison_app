class Image < ApplicationRecord
  belongs_to :post  # アソシエーション

  mount_uploader :image, article_image_uploader
end
