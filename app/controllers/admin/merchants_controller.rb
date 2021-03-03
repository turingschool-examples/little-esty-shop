class Admin::MerchantsController < ApplicationController
  before_action :find_merchant, only: [:show, :edit, :update]

  def index
    @merchants = Merchant.all
    @top_five = Merchant.top_five_merchants_by_revenue
  end

  def new
  end

  def create
    @merchant = Merchant.new(merchant_params)
    if @merchant.save
      flash[:notice] = "New merchant has been created!"
      redirect_to "/admin/merchants"
    else
      flash[:notice] = "Unable to create merchant!"
      render 'new'
    end
  end

  def show
  end

  def edit
  end

  def update
    if params[:status]
      if @merchant.update(merchant_params)
        redirect_to "/admin/merchants"
        flash[:notice] = "#{@merchant.name}'s status changed to #{@merchant.status}"
      end
    elsif @merchant.update(merchant_params)
      flash[:notice] = "Information successfully updated!"
      redirect_to "/admin/merchants/#{@merchant.id}"
    else
      flash[:notice] = "Unable to update information!"
      render 'edit'
    end
  end

  private

  def merchant_params
    params.permit(:name, :status)
  end

  def find_merchant
    @merchant = Merchant.find(params[:id])
  end
end
