class CreateTemporaryImages < ActiveRecord::Migration
  def change
    create_table :temporary_images do |t|
    	t.attachment :image
      t.timestamps null: false
    end
  end
end
