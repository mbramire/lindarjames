class CreateGalleryImages < ActiveRecord::Migration
  def change
    create_table :gallery_images do |t|
      t.string :title
      t.string :image
      t.text :description
      
      t.timestamps
    end
  end
end
