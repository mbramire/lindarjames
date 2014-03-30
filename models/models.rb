class Admin < ActiveRecord::Base
  validates :username, presence: true, uniqueness: true
  validates :password, presence: true
  has_secure_password
end

class GalleryImage < ActiveRecord::Base
  validates :image, presence: true
  validates :description, presence: true
  validates :title, presence: true
  mount_uploader :image, ImageUploader
end