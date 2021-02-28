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
    @merchant = Merchant.find(params[:id])
    if params[:status]
      @merchant.update(status: params[:status])
      redirect_to("/admin/merchants")
    else
      @merchant.update(name: params[:name])
      @merchant.save
      redirect_to("/admin/merchants/#{@merchant.id}")
    end
    flash[:notice] = "Merchant Updated!"
  end

  def new
  end

  def create
    Merchant.create!(name: params[:name])
    redirect_to "/admin/merchants"
  end
end
