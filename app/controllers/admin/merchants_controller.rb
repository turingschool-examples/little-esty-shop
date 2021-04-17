class Admin::MerchantsController < ApplicationController
  def index
    @enabled_merchants = Merchant.enabled #TODO: better here or in view?
    @disabled_merchants = Merchant.disabled
  end

  def show
    @merchant = Merchant.find(params[:id])
  end

  def edit
    @merchant = Merchant.find(params[:id])
  end

  def update
    merchant = Merchant.find(params[:id])
    merchant.update(merchant_params)
    if params[:status].present?
      redirect_to "/admin/merchants", notice: "Merchant Successfully Updated"
    else
      redirect_to "/admin/merchants/#{merchant.id}", notice: "Merchant Successfully Updated"
    end
  end

  def new
  end

  def create
    merchant = Merchant.new(merchant_params)
    if merchant.save
      redirect_to '/admin/merchants', notice: "Merchant Successfully Created"
    else
      redirect_to "/admin/merchants/new"
      flash[:alert] = "Error: #{error_message(merchant.errors)}"
    end
  end

  private
  def merchant_params
    if params[:status].present?
      params.permit(:status)
    else
      params.require(:merchant).permit(:name, :status)
    end
  end
end