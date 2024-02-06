class Product < ApplicationRecord
    belongs_to :category
    def category_name
        category = Category.find(self.category_id)
        category.category_name
    end


   scope :search_by_name_or_category_name, ->(search_term, status =nil) {
    query = joins(:category)
    .where('products.name LIKE :search OR categories.category_name LIKE :search', search: "%#{search_term}%")
    query =query.where(status: status) if status.present?
    query
  }

  scope :search_by_purchase_date_range, ->(start_date, end_date,status =nil) {
    query = where(purchase_date: start_date..end_date)
    query =query.where(status: status) if status.present?
    query
   }

  scope :search_by_name_or_category_date_range, ->(start_date, end_date, search_term, status=nil) {
  query = joins(:category)
          .where('products.name LIKE :search OR categories.category_name LIKE :search', search: "%#{search_term}%")
          .where(purchase_date: start_date..end_date)

  query = query.where(status: status) if status.present?

  query
  }



  def self.search(options = {})

    query = all
      if options[:name_or_category].present?
        if options[:purchase_date_start] == "" && options[:purchase_date_end] == ""
          if options[:status].present?
            query = query.search_by_name_or_category_name(options[:name_or_category], options[:status])
          else
            query = query.search_by_name_or_category_name(options[:name_or_category])
          end
        elsif options[:purchase_date_start].present? && options[:purchase_date_end].present?
          if options[:status].present?
            query = query.search_by_name_or_category_date_range(options[:purchase_date_start],options[:purchase_date_end], options[:name_or_category],  options[:status])
          else
            query = query.search_by_name_or_category_date_range(options[:purchase_date_start],options[:purchase_date_end], options[:name_or_category])
          end
        end
      else
        if options[:purchase_date_start] == "" || options[:purchase_date_end] == ""
         #raise options[:status].present?.inspect
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
          if options[:status].present?
          query = query.search_by_purchase_date_range(options[:purchase_date_start], options[:purchase_date_end],options[:status])
          else
              query = query.search_by_purchase_date_range(options[:purchase_date_start], options[:purchase_date_end])
          end
        elsif options[:purchase_date_start].present? && options[:purchase_date_end].present?
          if options[:status].present?
            query = query.search_by_purchase_date_range(options[:purchase_date_start], options[:purchase_date_end],options[:status])
          else
              query = query.search_by_purchase_date_range(options[:purchase_date_start], options[:purchase_date_end])
          end
        end
      end
    query

  end

end
