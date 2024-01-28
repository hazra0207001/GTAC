class ProductsController < ApplicationController
    def index
        #raise params.inspect
        #search_term = params[:search]
         #search_term = params[:name_or_category]

        if params[:name_or_category].present?
        #matching_categories = Category.where('name LIKE ?', "%#{search_term}%")

        @products = Product.joins("LEFT JOIN categories ON categories.id = products.category_id")
                    .where('products.name LIKE :search OR categories.category_name LIKE :search', search: "%#{params[:name_or_category]}%")
                    .distinct
        elsif params[:status].present?
            @products = Product.where(status: params[:status])
        else
        @products=Product.all
        end
        @tags =Tag.all
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
