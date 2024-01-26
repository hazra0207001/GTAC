class ProductsController < ApplicationController
    def index
        @products =Product.all
    end

    def new
        @product =Product.new
    end

    def create
        raise params[:name].inspect
        @product =Product.new(name: params['name'],unit: params['unit'],price: params['price'],purchase_date:params['purchase_date'])
        if @product.save
            redirect_to '/products', {notice: "saved succseefully"}
        else
            render :new
        end
    end

    def edit
        @product =Product.find(params['id'])
    end

    def update
        
        @product =Product.find(params['id'])
        @product.update(name: params[:name], unit: params[:unit], price: params[:price], purchase_date: params[:purchase_date])
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
