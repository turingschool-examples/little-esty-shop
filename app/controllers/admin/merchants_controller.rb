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
    @merchant = Merchant.find(params[:id])
    if params[:status].nil?
      if @merchant.update(merchant_params)
        redirect_to "/admin/merchants/#{@merchant.id}"
        flash[:notice] = "Successfully Updated"
      else
        redirect_to "/admin/merchants/#{@merchant.id}/edit"
        flash[:notice] = "Field cannot be blank"
      end
    else
      if params[:status] == "Enable"
        @merchant.status_update(1)
      else
        @merchant.status_update(0)
      end
      redirect_to "/admin/merchants"
      flash[:notice] = "Successfully Updated"
    end
  end

  def create 
    merchant = Merchant.new(merchant_params)
    merchant.save
    redirect_to "/admin/merchants"
  end

  private

  def merchant_params
    params.permit(:id, :name)
  end

end