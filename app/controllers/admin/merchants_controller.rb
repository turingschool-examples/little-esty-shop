class Admin::MerchantsController < ApplicationController
	def index
		@merchants = Merchant.all
	end

	def show
		@merchant = Merchant.find(params[:id])
	end

	def edit
		@merchant = Merchant.find(params[:id])
	end

	def update
		merchant = Merchant.find(params[:id])
		if merchant.update(name: merchant_name)
			# merchant.update(name: merchant_name)
			redirect_to admin_merchants_path
			flash[:notice] = "Merchant was successfully updated."
		else
			redirect_to edit_admin_merchant_path(merchant)
			flash[:alert] = error_message(merchant.errors)
		end
	end

	private

	def merchant_name
		params.permit(:name)[:name]
	end
end