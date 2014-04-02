class ChangeStringToIntegerCatId < ActiveRecord::Migration
  def change
    remove_column :gallery_images, :category_id
    add_column :gallery_images, :category_id, :integer
  end
end
