class ProductsController < ApplicationController
    def index
        #raise params.inspect

        #search_term = params[:search]
         #search_term = params[:name_or_category]

            def sort_data(sort_order, field_name)
                if @sort_order == 'asc'
                    @products = @products.order("#{field_name} COLLATE NOCASE ASC")
                else
                    @products = @products.order("#{field_name} COLLATE NOCASE DESC")
                end
                @products
            end




            search_params = {purchase_date_start: params[:purchase_date_start],purchase_date_end: params[:purchase_date_end], name_or_category:params[:name_or_category],status:params[:status]}
            #sorted_by = {sort_order_by_name: params[:sort_order_by_name]}

            products = Product.search(search_params )
            @products = products
            if params[:sort_order_by_name].present?
               @sort_order = params[:sort_order_by_name] || 'asc'
               field_name = "name"
               @products = sort_data(@sort_order, field_name)
            elsif params[:sort_order_by_price].present?
                @sort_order = params[:sort_order_by_price] || 'asc'
                field_name = "price"
               @products = sort_data(@sort_order, field_name)
            elsif params[:sort_order_by_unit].present?
                @sort_order = params[:sort_order_by_unit] || 'asc'
               field_name = "unit"
               @products = sort_data(@sort_order, field_name)
            elsif params[:sort_order_by_date].present?
                @sort_order = params[:sort_order_by_date] || 'asc'
               field_name = "purchase_date"
               @products = sort_data(@sort_order, field_name)
            end


            @next_sort_order = @sort_order == 'asc' ? 'desc' : 'asc'





    end

    def new
        @product =Product.new
        @categories =Category.all
        @tags =Tag.all

    end

    def create

        if params['tag_name'].present?
            tag = params['tag_name'].join(',')
        else
            tag = params['tag_name']
        end

        @product = Product.new(name: params['name'],unit: params['unit'],price: params['price'],purchase_date:params['purchase_date'],status:params['status'],category_id:params['category'],tags:tag)
        if @product.save
            redirect_to '/products', {notice: "saved succseefully"}
        else
            render :new
        end
    end

    def edit
        @product =Product.find(params['id'])
        @categories = Category.all
        @tags =Tag.all
    end

    def update
        #raise params.inspect
        @product =Product.find(params['id'])
        if params['tag_name'].present?
            tag = params['tag_name'].join(',')
        else
            tag = params['tag_name']
        end

        @product.update(name: params[:name], unit: params[:unit], price: params[:price], purchase_date: params[:purchase_date],status:params[:status],category_id:params[:category_id],tags:tag)
        if @product.save
            redirect_to '/products', {notice: "updated successfully"}
        else
            render :edit
        end
    end

    def show
        @product =Product.find(params['id'])
    end

    def destroy
        @product =Product.find(params['id'])
        if @product.destroy
            redirect_to '/products',{notice: "deleted succseefully"}
        end
    end


end
