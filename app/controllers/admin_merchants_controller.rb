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


  def new
    @merchant = Merchant.new
  end

  def create
    merchant = Merchant.new(merchant_params)
    if merchant.save
      redirect_to merchants_path, notice: 'Merchant Created Successfully'
    else
      redirect_to merchants_path, notice: 'A Required Field Was Missing; Merchant Not Created'
    end
  end

  def update
    merchant = Merchant.find(params[:id])
    if params[:update_status_to] == "disabled"
      merchant.disabled!
      redirect_to "/admin/merchants"
    elsif params[:update_status_to] == "enabled"
      merchant.enabled!
      redirect_to "/admin/merchants"
    elsif merchant.update(merchant_params)
      redirect_to "/admin/merchants/#{merchant.id}"
      flash[:notice] = 'Merchant Successfully Updated'
    else
      redirect_to "/admin/merchants/#{merchant.id}"
      flash[:notice] = 'A Required Field Was Missing; Merchant Not Updated'
    end
  end


  private
    def merchant_params
      params.require(:merchant).permit(:name, :status)
    end
end
