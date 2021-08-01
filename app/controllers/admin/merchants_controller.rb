class Admin::MerchantsController < ApplicationController
  def index
    @merchants = Merchant.all
  end

  def show
    @merchant = Merchant.find(params[:id])
  end
  
  def new
  end
  
  def create
    merchant = Merchant.new(merchants_params)

    if merchant.save
      redirect_to "/admin/merchants"
    else
      redirect_to "/admin/merchants/new"
      flash[:alert] = "Error: #{error_message(merchant.errors)}"
    end
  end
  
  def edit
    @merchant = Merchant.find(params[:id])
  end
  
  def update
    merchant = Merchant.find(params[:id])
    if params[:status] == "disabled"
      merchant.update(status: "enabled")
      redirect_to "/admin/merchants"
    elsif params[:status] == "enabled"
      merchant.update(status: "disabled")
      redirect_to "/admin/merchants"
    elsif merchant.update(merchants_params)
      redirect_to "/admin/merchants/#{merchant.id}"
      flash[:alert] = "Merchant Successfully updated!"
    else
      redirect_to "/admin/merchants/#{merchant.id}/edit"
      flash[:alert] = "Error: #{error_message(merchant.errors)}"
    end
  end
  
  # def destroy
    
  # end

private
  def merchants_params
    params.require(:merchant).permit(:name)
  end
end