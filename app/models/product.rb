class Product < ActiveRecord::Base
	
	has_many :upload_images, :dependent => :destroy
	has_many :product_categories, :dependent => :destroy
	has_many :categories, :through => :product_categories

	accepts_nested_attributes_for :upload_images, allow_destroy: true, reject_if: :all_blank
	accepts_nested_attributes_for :categories, allow_destroy: true, reject_if: :all_blank
	validates_presence_of :name,  :message => "Please enter name"
	validates_presence_of :name, :on => :update, :message => "Please enter name"
	# validate :check_category
	# validate :image_presence

	def image_presence
		if self.upload_images.present?
			return true
		else
			errors.add(:name, "Please select image") if !(self.upload_images.present?)
		end
	end

	# def check_category
	# 	binding.pry
	# end
end
