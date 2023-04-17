class MerchantsController < ApplicationController
  def index
    @merchants = Merchant.all
  end

  def show
    @merchant = Merchant.find(params[:merchant_id])
  end

  def update
    merchant = Merchant.find(params[:id])
    if params[:merchant][:is_enabled]
      merchant.update(merchant_params)
      redirect_to admin_merchants_path
    end
    if params[:merchant][:name]
      if merchant.update(merchant_params)
        redirect_to admin_merchant_path(merchant)
        flash[:success] = "Information has been successfully updated"
      else
        redirect_to edit_admin_merchant_path(merchant)
        flash[:alert] = "Error: #{merchant.errors.full_messages.to_sentence}"
      end
    end
  end

  def new
    @merchant = Merchant.new
  end

  def create
    @merchant = Merchant.new(merchant_params)
    if @merchant.save
      redirect_to admin_merchants_path
      flash[:success] = "New merchant has been successfully created"
    else
      redirect_to new_merchant_path
      flash[:alert] = "Error: #{@merchant.errors.full_messages.to_sentence}"
    end
  end


  private
  def merchant_params
    params.require(:merchant).permit(:name, :is_enabled)
  end
end