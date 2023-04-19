class Admin::MerchantsController < ApplicationController
  def index
    @merchants = Merchant.all
    @image_search = ImageSearch.new
    @images = @image_search.images("street corner")
  end

  def show
    @merchant = Merchant.find(params[:id])
  end

  def edit
    @merchant = Merchant.find(params[:id])
  end

  def update
    @merchant = Merchant.find(params[:id])
    if @merchant.update(merchant_params)
      flash[:success] = "Merchant Updated"
      redirect_to admin_merchant_path(@merchant)
    else
      flash[:notice] = "Merchant Update Failed"
      redirect_to edit_admin_merchant_path(@merchant)
    end
  end

  private
  def merchant_params
    params.permit(:name)
  end
end