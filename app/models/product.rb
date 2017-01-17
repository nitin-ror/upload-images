class Product < ActiveRecord::Base
	has_many :upload_images, :dependent => :destroy
	accepts_nested_attributes_for :upload_images, allow_destroy: true
	validates :name, presence: true
end
