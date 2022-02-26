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

  def update
    if params[:_method] == 'patch'
      merchant = Merchant.find(params[:id])
      merchant.update(name: params[:name])
      redirect_to "/admin/merchants/#{merchant.id}"
    else
      @merchant = Merchant.find(params[:id])
      @merchant.update(status: params[:status])
      redirect_to "/admin/merchants"
    end
  end

  def create
    Merchant.create!(name: params[:name])
    redirect_to "/admin/merchants"
  end

end
