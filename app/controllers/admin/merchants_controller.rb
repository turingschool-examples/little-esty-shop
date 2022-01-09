class Admin::MerchantsController < ApplicationController

  def index
    @merchants = Merchant.all
  end

  def show
    @merchant = Merchant.find(admin_merchant_params[:id])
  end

  def new 
    merchant = Merchant.new
  end

  def create 
    merchant = Merchant.new(admin_merchant_params)

    if merchant.save
      redirect_to "/admin/merchants"
    else
      redirect_to "/admin/merchants/new"
      flash[:alert] = "Error: #{error_message(merchant.errors)}"
    end
  end

  def edit
    @merchant = Merchant.find(admin_merchant_params[:id])
  end

  def update
    merchant = Merchant.find(params[:id])

    if merchant.update(admin_merchant_params)
      flash[:success] = merchant.name + ' was successfully updated.'

      if(params[:redirect_to]) == "index"
        redirect_to admin_merchants_path
      else
        redirect_to admin_merchant_path(params[:id])
      end

    else
      flash[:alert] = "Error: #{error_message(merchant.errors)}"
    end 
  end

private 

  def admin_merchant_params
    params.permit(:id, :name, :status)
  end

end
