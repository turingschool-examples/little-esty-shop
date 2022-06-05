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
    merch = Merchant.find(merch_params[:id])
    merch.update(merch_params)
    redirect_to "/admin/merchants/#{merch.id}"
  end

  private

  def merch_params
    params.permit(:id, :name)
  end
end
