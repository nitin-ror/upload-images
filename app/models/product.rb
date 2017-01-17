class Product < ActiveRecord::Base
	has_many :upload_images, :dependent => :destroy
	accepts_nested_attributes_for :upload_images, allow_destroy: true, reject_if: :all_blank
	validates_presence_of :name,  :message => "Please enter name"
	# validate :image_presence

	def image_presence
		if self.upload_images.present?
			return true
		else
			errors.add(:name, "Please select image") if !(self.upload_images.present?)
		end
	end
end
