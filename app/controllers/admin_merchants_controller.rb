class AdminMerchantsController < ApplicationController

  def index
    @merchants = Merchant.all
  end

  def show
    @merchant = Merchant.find(params[:merchant_id])
  end

  def new
  end

  def create
    merchant = Merchant.create!(merchant_params)
    redirect_to "/admin/merchants"
  end

  def edit
    @merchant = Merchant.find(params[:merchant_id])
  end

  def update
    merchant = Merchant.find(params[:merchant_id])
    if params.include?(:status)
      merchant.update(merchant_params)
      redirect_to '/admin/merchants'
    elsif params.include?(:merchant_update)
      if merchant.update(merchant_params)
        flash[:notice] = "Successfully Updated Information"
        redirect_to "/admin/merchants/#{merchant.id}"
      else
        redirect_to "/admin/merchants/#{merchant.id}/edit"
        flash[:alert] = "Error: #{error_message(merchant.errors)}"
      end
    end
  end

  private

    def merchant_params
      params.permit(:name, :updated_at, :status, :created_at)
    end
end
