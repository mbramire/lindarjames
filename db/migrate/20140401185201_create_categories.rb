class CreateCategories < ActiveRecord::Migration
  def change
    create_table :categories do |t|
      t.string :name
      t.text :description
      t.timestamps
    end

    add_column :gallery_images, :category_id, :string
  end
end
