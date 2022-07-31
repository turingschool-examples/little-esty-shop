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

  def new
  end

  def create
    merchant = Merchant.new(merchant_params)
    if merchant.save
      redirect_to "/admin/merchants"
      flash.clear
    else
      redirect_to "/admin/merchants/new"
      flash[:alert] = "Error: Field Cannot Be Blank"
    end
  end

  def update
    merchant = Merchant.find(params[:id])
    if merchant.update(merchant_params)
      redirect_to "/admin/merchants/#{merchant.id}"
      flash.clear
      flash[:success] = "Update to #{merchant.name} was successful!"
    else
      redirect_to "/admin/merchants/#{merchant.id}/edit"
      flash[:alert] = "Error: Field Cannot Be Blank"
    end
  end

  private
    def merchant_params
      params.permit(:name, :status)
    end

end