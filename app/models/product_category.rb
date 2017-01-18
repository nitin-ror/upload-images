class ProductCategory < ActiveRecord::Base
	belongs_to :product
	belongs_to :category

	# def self.check_present(obj)
	# 	binding.pry
	# 	if !(obj.present?)
	# 		errors.add(:name,"Can't Be Blank ")
	# 	end
	# end
end
