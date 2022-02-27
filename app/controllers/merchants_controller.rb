class MerchantsController < ApplicationController
  def show
    repo_name
    @merchant = Merchant.find(params[:id])
  end

  def update
    merchant = Merchant.find(params[:id])
    merchant.update(name: params[:name])
    redirect_to "/admin/merchants/#{merchant.id}"
  end
end
