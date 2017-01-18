class ProductsController < ApplicationController
	def index
		@products = Product.all
	end

	def new
		@product = Product.new
	end

	def create
		@product = Product.new(product_params)
		category_ids = params[:product][:product_categories][:name].reject(&:blank?)
		if category_ids.present?
			if @product.save
				category_ids = params[:product][:product_categories][:name].reject(&:blank?)
				category_ids.each do |id|
					ProductCategory.create(product_id: @product.id, category_id: id)
				end
				redirect_to products_path
			else
				render 'new'	
			end
		else
			flash[:message] = "please select category"
			render 'new'
		end
	end

	def edit
		@product = Product.find(params[:id])
	end

	def update
		@product = Product.find(params[:id])
		if @product.update(product_params)
			category_ids = params[:product][:product_categories][:name].reject(&:blank?)
			category_ids.each do |id|
				ProductCategory.create(product_id: @product.id, category_id: id)
			end
			redirect_to products_path
		end
	end

	def temp_image_update
		@temp_image = TemporaryImage.new(image: params[:media_file])
	end

	private

	def product_params
    params.require(:product).permit(:name, :categories_attributes => [:id, :name])
  end
end
