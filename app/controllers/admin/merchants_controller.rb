class Admin::MerchantsController < ApplicationController
 	 def index
	  @merchants = Merchant.all
	 end

	 def show
		@merchant = Merchant.find(params[:id])
	 end

   def new
    @merchant = Merchant.new
   end

   def create
     if Merchant.create(merchant_params) && merchant_params[:name].empty? == false
         flash[:alert] = "Merchant has been successfully created"
         redirect_to admin_merchants_path
      else
        flash[:alert] = "Failed to create merchant"
        redirect_to "/admin/merchants/new"
      end
   end

   def edit
		@merchant = Merchant.find(params[:id])
   end

   def update
     merchant = Merchant.find(params[:id])

     if params[:enable]
       merchant.update(status: 1)
       redirect_to "/admin/merchants"
     elsif params[:disable]
       merchant.update(status: 0)
       redirect_to "/admin/merchants"

     else
       if merchant_params[:name] != merchant.name && merchant.update(merchant_params)
         flash[:alert] = "Information has been successfully updated"
         redirect_to "/admin/merchants/#{merchant.id}"
       else
         flash[:alert] = "Failed to update merchant"
         redirect_to "/admin/merchants/#{merchant.id}/edit"
       end
     end
   end

private
   def merchant_params
    params.require(:merchant).permit(:name)
   end
end
