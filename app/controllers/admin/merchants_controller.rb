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
    if params[:status]
      enable_disable_logic
    elsif @merchant.update(merchant_params) && !params[:status]
      flash[:notice] = "Merchant Updated Successfully"
      redirect_to admin_merchant_path(@merchant)
    end
  end

  def create
    merchant = Merchant.create!(name: params[:merchant][:name],
                     id: find_new_id)
    if merchant.save
      flash[:notice]= 'Merchant Has Been Created!'
      redirect_to admin_merchants_path
    # else
    #   flash[:error] = "Merchant not created due to invalid input."
    #   redirect_to new_admin_merchant_path
    end
  end

  private

  def enable_disable_logic
    if params[:status] == "enable"
      @merchant.enable_merchant
      flash[:notice] = "#{@merchant.name} Enabled"
      redirect_to admin_merchants_path
    else
      @merchant.disable_merchant
      flash[:notice] = "#{@merchant.name} Disabled"
      redirect_to admin_merchants_path
    end
  end

   def merchant_params
     params.require(:merchant).permit(:name)
   end

   def find_new_id
    Merchant.last.id + 1
  end

end
