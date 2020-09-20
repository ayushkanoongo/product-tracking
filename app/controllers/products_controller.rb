class ProductsController < ApplicationController
	before_action :get_products, only: [:edit, :update, :destroy, :received, :received_return, :create_received_return]

	def index
		if params[:term]
			@products = Product.search_by_serial_number(params[:term]).page params[:page]
		else
			@products = Product.all.order(created_at: :desc).page params[:page]
		end
	end

	def new
		@product = Product.new
	end

	def create
		@product = Product.new(product_params)
		if @product.save
			flash[:success] = "Entry is successfully saved."
			redirect_to products_path
		else
			flash[:danger] = @product.errors.full_messages
			redirect_to new_product_path
		end
	end

	def edit
	end

	def update
		if @product.update(product_params)
			flash[:success] = "Entry is successfully updated."
			redirect_to products_path
		else
			flash[:danger] = @product.errors.full_messages
			redirect_to edit_product_path(@product.id)
		end
	end

	def destroy
		@product.destroy
		flash[:success] = "Entry is successfully deleted."
		redirect_to products_path
	end

	def received
		@product.update(status: 1, receive_date: Time.now)
		flash[:success] = "Product is successfully received."
		redirect_to products_path
	end

	def received_return
	  respond_to do |format|
	    format.html
	    format.js
	  end
	end

	def create_received_return
		if params[:new_serial_number].present?
			product = Product.new
			product.serial_number = params[:new_serial_number]
			product.buyer_name = @product.buyer_name
			product.mobile = @product.mobile
			product.address = @product.address
			product.product_type = @product.product_type
			product.status = 0
			product.save! 
			@product.update(status: 1, receive_date: Time.now)
			redirect_to products_path	
		else
			flash[:danger] = "Product serial number missing."
			redirect_to products_path
		end
	end

	private

	def product_params
		params.require(:product).permit(:serial_number, :buyer_name, :mobile, :product_type, :email, :address, :status)
	end

	def get_products
		@product = Product.find(params[:id])
	end

end
