class AdminMerchantsController < ApplicationController
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
    if params[:merchant_id]
      merch = Merchant.find(params[:merchant_id])
      if merch.status == "disabled" 
        merch.status = "enabled"
      else 
        merch.status = "disabled"
      end
      merch.save
      redirect_to "/admin/merchants"
    else
      merch = Merchant.find(merch_params[:id])
      merch.update(merch_params)
      redirect_to "/admin/merchants/#{merch.id}"
      flash[:message] = 'Merchant has been successfully updated!'
    end
  end

  def new

  end

  def create
    merchant = Merchant.create!(merch_params)
    redirect_to "/admin/merchants"
  end

  private

  def merch_params
    params.permit(:id, :name)
  end
end
