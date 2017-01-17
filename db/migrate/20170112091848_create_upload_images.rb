class CreateUploadImages < ActiveRecord::Migration
  def change
    create_table :upload_images do |t|
    	t.integer :product_id
    	t.attachment :image
      t.timestamps null: false
    end
  end
end
