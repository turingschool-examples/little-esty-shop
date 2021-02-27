class Admin::MerchantsController < ApplicationController
	def index
		@enabled_merchants = Merchant.enabled_merchants
		@disabled_merchants = Merchant.disabled_merchants
		@top_five_merchants = Merchant.top_five_merchants
	end

	def show
		@merchant = Merchant.find(params[:id])
	end

	def edit
		@merchant = Merchant.find(params[:id])
	end

	def new

	end

	def create
		@merchant = Merchant.new(name: params[:name])
		require "pry"; binding.pry
		@merchant.save
		redirect_to "/admin/merchants"
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
		params.permit(:id, :name)
	end

end
