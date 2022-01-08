class Admin::AdminMerchantsController < ApplicationController

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
    merchant = Merchant.find(params[:id])
    merchant.update(merchant_params)
    if params[:status].present?
      redirect_to action: :index
    end
  end

  def new
  end

  def create
    Merchant.create!(merchant_params)
    redirect_to "/admin/merchants"
  end

  private

  def merchant_params
    params.permit(:name, :status)
  end

end
