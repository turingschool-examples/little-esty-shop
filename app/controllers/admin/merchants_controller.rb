class Admin::MerchantsController < ApplicationController
  before_action :find_merchant, only: [:show, :edit, :update]

  def index
    @merchants = Merchant.all
  end

  def show
  end

  def edit
  end

  def update
    if @merchant.update(merchant_params)
      flash[:notice] = "Information successfully updated!"
      redirect_to "/admin/merchants/#{@merchant.id}"
    else
      flash[:notice] = "Unable to update information!"
      render 'edit'
    end
  end

  private

  def merchant_params
    params.permit(:name)
  end

  def find_merchant
    @merchant = Merchant.find(params[:id])
  end
end
