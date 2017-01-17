class UploadImagesController < ApplicationController

	def index
		@images = UploadImage.all
	end

	def new
		@image = UploadImage.new
	end

	def create
		if upload_image_params[:image].present?
			upload_image_params[:image].each do |image|
				UploadImage.create(image: image)
			end
			redirect_to upload_images_path
		else
			render 'new'
		end
	end

	private

	 def upload_image_params
    params.require(:upload_image).permit!
  end
end
