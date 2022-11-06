class Admin::MerchantsController < ApplicationController
  def show
    @merchant = Merchant.find(params[:id])
  end
  
  def index
    @merchants = Merchant.all
  end

  def edit
    @merchant = Merchant.find(params[:id])
  end 

  def update
    merchant = Merchant.find(params[:id])
    if params[:enabled]
      merchant.update(status: 1)
      redirect_to "/admin/merchants"
    elsif params[:disabled]
      merchant.update(status: 0)
      redirect_to "/admin/merchants"
    elsif params[:name].empty?
      redirect_to "/admin/merchants/#{merchant.id}/edit"
      flash[:alert] = "Empty name not permitted. Please input valid name"
    else
      merchant.update(merchant_params)
      redirect_to "/admin/merchants/#{merchant.id}"
      flash[:notice] = "Successfully Updated: #{merchant.name}"
    end
  end

  def new
    @merchant = Merchant.new
  end

  def create
    merchant = Merchant.new(merchant_params)
    # require 'pry'; binding.pry
    if merchant.save
      redirect_to "/admin/merchants"
    else
      redirect_to "/admin/merchants/new"
      flash[:alert] = "ERROR: Please enter a valid name."
    end
  end

  private
  def merchant_params
    params.permit(:id, :name, :status)
  end
end