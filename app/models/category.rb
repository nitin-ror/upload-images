class Category < ActiveRecord::Base
	# belongs_to :product
	has_many :product_categories, :dependent => :destroy
	has_many :products, :through => :product_categories

	validates_uniqueness_of :name, message: "Category name already taken!"
	validates_presence_of :name, message: "Please enter category name"
	# before_destroy :check_products


	def check_products
		if self.products.present?
			return false
		else
			return true
		end
	end

end
