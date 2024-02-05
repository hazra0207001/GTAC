class Product < ApplicationRecord
    belongs_to :category
    def category_name
        category = Category.find(self.category_id)
        category.category_name
    end


   scope :search_by_name_or_category_name, ->(search_term, status) {
      joins(:category)
    .where('products.name LIKE :search OR categories.category_name LIKE :search', search: "%#{search_term}%")
    .where(status: status)
}

  scope :search_by_purchase_date_range, ->(start_date, end_date) { where(purchase_date: start_date..end_date) if start_date.present? && end_date.present? }

 scope :search_by_name_or_category_date_range, ->(start_date, end_date, search_term) {
  query = joins(:category)
    .where('products.name LIKE :search OR categories.category_name LIKE :search', search: "%#{search_term}%")

  query = query.where(purchase_date: start_date..end_date) if start_date.present? && end_date.present?

  query
}



  def self.search(options = {})
  #raise options.inspect
    query = all
    if options[:name_or_category] != "" && options[:purchase_date_start]=="" && options[:purchase_date_end]==""

        query = query.search_by_name_or_category_name(options[:name_or_category], options[:status])


    elsif options[:purchase_date_start] !="" && options[:purchase_date_end] !="" && options[:name_or_category] ==""
        query = query.search_by_purchase_date_range(options[:purchase_date_start], options[:purchase_date_end])



    elsif options[:purchase_date_start] !="" || options[:purchase_date_end]!="" && options[:name_or_category] !=""
        if options[:purchase_date_start] ==""
            options[:purchase_date_start] =Date.new(1900, 2, 4).strftime("%Y-%m-%d")
         else
            options[:purchase_date_start] = options[:purchase_date_start]
         end
         if options[:purchase_date_end] ==""
            options[:purchase_date_end] =Date.current.strftime("%Y-%m-%d")
         else
            options[:purchase_date_end] = options[:purchase_date_end]
         end
      query = query.search_by_name_or_category_date_range(options[:purchase_date_start], options[:purchase_date_end], options[:name_or_category])

    end
    query
  end

end
