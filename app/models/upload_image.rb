class UploadImage < ActiveRecord::Base
	# has_attached_file :image, :styles => { :small => "150x150>" }
	belongs_to :product
  has_attached_file :image, {:styles => {:large => "640x640>",
                                         :small => "200x200>", 
                                         :thumb => "60x60>"}}#.merge(UPLOAD_IMAGE_PATH)

	validates_attachment_presence :image
	validates_attachment_size :image, :less_than => 2.megabytes
	validates_attachment_content_type :image, :content_type => ['image/jpeg', 'image/png']
	validates_presence_of :image,  :message => "Please enter Image"
	validate :image_validation#, :if => "image?"  
	# before_validation :check_image
  def image_validation
    errors.add(:image, "size can't less than 5 MB") if self.image.size < 5000
  end
  def self.check_image(product)
  	binding.pry
  	errors.add(:image, "size can't less than 5 MB")
  end
end
