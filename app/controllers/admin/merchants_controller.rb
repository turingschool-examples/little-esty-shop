class Admin::MerchantsController < ApplicationController
	def index
		@active_merchants = Merchant.active_merchants
		@disabled_merchants = Merchant.disabled_merchants
	end

	def show
		@merchant = Merchant.find(params[:id])
	end

	def edit
		@merchant = Merchant.find(params[:id])
	end

	def update
		merchant = Merchant.find(params[:id])
		if params[:status].present?
			merchant.update status: params[:status]
			redirect_to admin_merchants_path
		elsif merchant.update(name: params[:name])
			redirect_to admin_merchants_path
			flash[:notice] = "Merchant was successfully updated."
		else
			redirect_to edit_admin_merchant_path(merchant)
			flash[:alert] = error_message(merchant.errors)
		end
	end
end