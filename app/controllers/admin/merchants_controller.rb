class Admin::MerchantsController < ApplicationController
    
    def index
        @merchants = helpers.sortable(Merchant.all, params)
    end
    
    def new
    end
    
    def create
        @merchant = Merchant.create!({name: params[:name], status: 1})
        redirect_to "/admin/merchants/", notice: "#{@merchant.name} Added"
    end

    def show 
        @merchant = Merchant.find(params[:id])
    end
    
    def edit
        @merchant = Merchant.find(params[:id])
    end
    
    def update
        @merchant = Merchant.find(params[:id])
        if params[:status] == 'Disable'
            @merchant.disabled!
            redirect_to "/admin/merchants/", notice: "Status changed"
        elsif params[:status] == 'Enable' 
            @merchant.enabled!
            redirect_to "/admin/merchants/", notice: "Status changed"
        else
            @merchant.update(merchant_params)
            redirect_to "/admin/merchants/#{@merchant.id}", notice: "Successfully Updated"
        end 
    end


    private
        def merchant_params
            params.permit(:name)
        end
end