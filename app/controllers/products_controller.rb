class ProductsController < ApplicationController
	before_action :get_products, only: [:edit, :update, :destroy, :received, :received_return, :create_received_return, :destroy_item, :return_items, :exchange]

	def index
		if params[:term]
			@products = Product.search_by_serial(params[:term]).page params[:page]
			if @products.length == 0
				@products = Product.search_by_name(params[:term]).page params[:page]
			end
		else
			@products = Product.all.order(created_at: :desc).page params[:page]
		end
	end

	def new
		@product = Product.new
	end

	def create
		if params[:commit] == "create exchange"
			@product = Product.new(product_params)
			if @product.save
				flash[:success] = "Product is successfully crated."
				redirect_to products_path
			else
				flash[:danger] = @product.errors.full_messages
				redirect_to new_product_path
			end
		else
			@product = Product.new(product_params)
			if @product.save
				flash[:success] = "Product is successfully crated."
				redirect_to products_path
			else
				flash[:danger] = @product.errors.full_messages
				redirect_to new_product_path
			end
		end
	end

	def edit
	end

	def update
		if @product.update(product_params)
			flash[:success] = "Entry is successfully updated."
			redirect_to return_items_product_path(@product.id)
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

	def destroy_item
		if params[:item_id].present?
			item = @product.items.where(id: params[:item_id]).try(:first)
			item.destroy
			flash[:success] = "Item is successfully deleted."
			redirect_to edit_product_path(@product.id)
		end
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

	def exchange
		@new_product = Product.new
	end

	def return_items
	end

	private

	def product_params
		params.require(:product).permit(:serial_number, :patient_name, :mobile, :product_type, :email, :address, :status, :doctor_name, :receive_date, items_attributes: Item.attribute_names.map(&:to_sym).push(:_destroy))
	end

	def get_products
		@product = Product.find(params[:id])
	end

end
