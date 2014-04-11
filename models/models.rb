class Admin < ActiveRecord::Base
  validates :username, presence: true, uniqueness: true
  validates :password, presence: true
  has_secure_password
end

class GalleryImage < ActiveRecord::Base
  validates :image, presence: true
  validates :description, presence: true
  validates :title, presence: true
  validates :category_id, presence: true
  belongs_to :category
  mount_uploader :image, ImageUploader

  def self.get_homepage_images
    images = GalleryImage.where(homepage: true)
    sorted = {}
    images.each do |img|
      sorted[img[:position]] = img
    end
    sorted
  end
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

class Category < ActiveRecord::Base
  validates :name, presence: true
  validates :description, presence: true
  has_many :gallery_images
end

class Contact
  include ActiveModel::Validations
  include ActiveModel::Conversion
  extend ActiveModel::Naming

  validates :your_email, presence: true, format: { with: /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z]+)*\.[a-z]+\z/i }
  validates :body, presence: true
  validates :your_name, presence: true

  attr_accessor :body, :your_email, :your_name

  def initialize(attributes = {})
    attributes.each do |name, value|
      send("#{name}=", value)
    end
  end
  
  def persisted?
    false
  end
end