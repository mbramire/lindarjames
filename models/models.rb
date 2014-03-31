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

class Post < ActiveRecord::Base
  validates :title, presence: true
  validates :content, presence: true
end

class Document < ActiveRecord::Base
  validates :doc, presence: true
  validates :title, presence: true
  validates :description, presence: true
  mount_uploader :doc, DocumentUploader
end