class Product < ApplicationRecord
    def category_name
        category = Category.find(self.category_id)
        category.category_name
    end
    
end
