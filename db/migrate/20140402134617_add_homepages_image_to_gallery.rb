class AddHomepagesImageToGallery < ActiveRecord::Migration
  def change
    add_column :gallery_images, :homepage, :boolean, default: false
  end
end
