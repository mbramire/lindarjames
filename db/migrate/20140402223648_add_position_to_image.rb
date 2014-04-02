class AddPositionToImage < ActiveRecord::Migration
  def change
    add_column :gallery_images, :position, :integer
  end
end
