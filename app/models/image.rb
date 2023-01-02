class Image < ApplicationRecord
  belongs_to :post  # アソシエーション
mount_uploader :url, ImageUploader
end
