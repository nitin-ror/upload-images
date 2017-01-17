class ProductsController < ApplicationController
	def index
		@products = Product.all
	end

	def new
		@product = Product.new
		@product.upload_images.build
	end

	def create
		@product = Product.new(product_params)
		if @product.save
			params[:product][:upload_images_attributes]["0"][:image].each do |image|
				@product.upload_images.create(image: image)
			end
			redirect_to products_path
		else
			@product.upload_images.build
			render 'new'
		end
	end
	def temp_image_update
		@temp_image = TemporaryImage.new(image: params[:media_file])
	end
	private

	def product_params
    params.require(:product).permit(:name, :upload_images_attributes => [:id, :image])
  end
end
