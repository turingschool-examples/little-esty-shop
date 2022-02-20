class Admin::MerchantsController < ApplicationController
  def index
    @merchants = Merchant.all
  end

  def new
  end

  def show
    @merchant = Merchant.find(params[:id])
  end

  def edit
    @merchant = Merchant.find(params[:id])
  end

  def create
    merchant = Merchant.create(merchant_params)

    if merchant.save
      redirect_to "/admin/merchants"
    else
      redirect_to "/admin/merchants/new"
      #flash[:alert] = "Error: #{error_message(app.errors)}"
    end
  end

  def update
    merchant = Merchant.find(params[:id])
    merchant.update(merchant_params)

    if merchant.save
      redirect_to "/admin/merchants/#{merchant.id}"
      flash[:alert] = "Merchant successfully updated!"
    else
      redirect_to "/admin/merchants/#{merchant.id}/edit"
    end
  end

  private

    def merchant_params
      param_hash = {}

      param_hash[:name] = params[:name] unless params[:name] == ""
      param_hash[:status] = params[:status] unless params[:status] == ""

      param_hash
    end


end
