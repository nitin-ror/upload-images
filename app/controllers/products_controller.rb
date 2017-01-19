class ProductsController < ApplicationController

	before_action :find_product, only:[:edit, :update, :destroy]

	def index
		@products = Product.all
	end

	def new
		@product = Product.new
	end

	def create
		@product = Product.new(product_params)
		category_ids = params[:product][:product_categories][:category_id].reject(&:blank?)
		if category_ids.present?
			if @product.save
				category_ids = params[:product][:product_categories][:category_id].reject(&:blank?)
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

	def update
		category_ids = params[:product][:product_categories][:category_id].reject(&:blank?)
		if category_ids.present?
			if @product.update(product_params)
				ProductCategory.where(product_id: @product.id).destroy_all
				category_ids.each do |id|
					ProductCategory.create(product_id: @product.id, category_id: id)
				end
				redirect_to products_path
			else
				render "new", :locals => { :template => @product.id }	
			end
		else
			flash[:message] = "please select category"
			render "new", :locals => { :template => @product.id }
		end
	end

	def destroy
		@product.destroy
		redirect_to products_path
	end

	def temp_image_update
		@temp_image = TemporaryImage.new(image: params[:media_file])
	end

	private

	def find_product
		@product = Product.find(params[:id])
	end

	def product_params
    params.require(:product).permit(:name, :categories_attributes => [:id, :name])
  end
end
