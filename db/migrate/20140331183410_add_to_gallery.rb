class AddToGallery < ActiveRecord::Migration
  def change
    add_column :gallery_images, :medium, :string
    add_column :gallery_images, :scale, :string
    add_column :gallery_images, :date, :string

    create_table :posts do |t|
      t.string :title
      t.text :content
      t.timestamps
    end

    create_table :documents do |t|
      t.string :title
      t.text :description
      t.string :doc
      t.timestamps
    end
  end
end
