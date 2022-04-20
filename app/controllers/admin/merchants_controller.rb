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

  def create
    @new_merchant = Merchant.create!(merchant_params)
    redirect_to "/admin/merchants"
  end

  def update
    merchant = Merchant.find(params[:id])
      if params[:name].present?
        merchant.update!(name: params[:name])
        merchant.save
        flash.alert = "INFO HAS BEEN UPDATED!!!!!"
        redirect_to "/admin/merchants/#{merchant.id}"
      elsif merchant.status == nil || merchant.status == "disabled"
        merchant.update!(status: "enabled")
        merchant.save
        redirect_to "/admin/merchants"
      else
        merchant.update!(status: "disabled")
        merchant.save
        redirect_to "/admin/merchants"
      end
  end

  def new
  end

  private
  def merchant_params
    params.permit(:name)
  end
end
