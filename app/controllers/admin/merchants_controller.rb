class Admin::MerchantsController < ApplicationController
	def index
		@enabled_merchants = Merchant.enabled_merchants
		@disabled_merchants = Merchant.disabled_merchants
	end

	def show
		@merchant = Merchant.find(params[:id])
	end

	def edit
		@merchant = Merchant.find(params[:id])
	end

	def update
		@merchant = Merchant.find(params[:id])
		if params[:status]
				@merchant.update(merchant_params)
			redirect_to '/admin/merchants'
		else
			@merchant.update(merchant_params)
			flash.now[:success] = 'Merchant updated successfully'
    	render :show
		end
	end

	private
	def merchant_params
		params.permit(:name, :status)
	end

end
