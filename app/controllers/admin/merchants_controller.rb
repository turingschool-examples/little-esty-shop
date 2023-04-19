class Admin::MerchantsController < ApplicationController
  def index
    @merchants = Merchant.all
    @merchants_enabled = Merchant.where(status: 'enabled')
    @merchants_disabled = Merchant.where(status: 'disabled')
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
       if params[:name].nil?
        toggle_status
        redirect_to admin_merchants_path
      else
        flash[:success] = "Merchant Updated"
        redirect_to admin_merchant_path(@merchant)
      end
    else
      flash[:notice] = "Merchant Update Failed"
      redirect_to edit_admin_merchant_path(@merchant)
    end
  end

  def toggle_status
    @merchant = Merchant.find(params[:id])
    if @merchant.enabled?
      @merchant.disabled!
      flash[:notice] = "Merchant Disabled"
    else
      @merchant.enabled!
      flash[:notice] = "Merchant Enabled"
    end
  end

  private
  def merchant_params
    params.permit(:name, :status, :update_form)
  end
end