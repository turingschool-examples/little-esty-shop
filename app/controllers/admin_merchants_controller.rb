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

  def update
    merchant = Merchant.find(params[:id])

    if params[:status]
      merchant.status = params[:status]
      merchant.save
      redirect_to "/admin/merchants"
    else
      merchant.update(name: params[:name])
      redirect_to "/admin/merchants/#{merchant.id}", notice: "Update Successful"
    end

  end
end
