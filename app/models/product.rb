class Product < ApplicationRecord
    belongs_to :category
    def category_name
        category = Category.find(self.category_id)
        category.category_name
    end


   scope :search_by_name_or_category_name, ->(search_term) {
    joins(:category)
      .where('products.name LIKE :search OR categories.category_name LIKE :search', search: "%#{search_term}%")
  }

  scope :search_by_purchase_date_range, ->(start_date, end_date) { where(purchase_date: start_date..end_date) if start_date.present? && end_date.present? }





  def self.search(options = {})
  #raise options["name_or_category"].inspect
    query = all
    if options["name_or_category"] != ""
        query = query.search_by_name_or_category_name(options["name_or_category"])
    end
    if options["purchase_date_start"] && options["purchase_date_end"] && options["name_or_category"] ==""
        query = query.search_by_purchase_date_range(options["purchase_date_start"], options["purchase_date_end"])
    end
    query
  end

end
