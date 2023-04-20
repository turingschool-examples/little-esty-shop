class Admin::MerchantsController < ApplicationController
  def index
    @image_search = ImageSearch.new
    @logo = @image_search.images("Big Pharma")
    @merchants = Merchant.all
    @images = @image_search.images("street corner")
    @merchants_enabled = Merchant.where(status: 'enabled')
    @merchants_disabled = Merchant.where(status: 'disabled')
  end

  def show
    @image_search = ImageSearch.new
    @logo = @image_search.images("Big Pharma")
    @merchant = Merchant.find(params[:id])
  end

  def edit
    @image_search = ImageSearch.new
    @logo = @image_search.images("Big Pharma")
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