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
    merchant = Merchant.find(params[:id])
    merchant.update(merchant_params)
    if params[:merchant].include?(:name)
      flash.notice = "Merchant was successfully updated!" 
      redirect_to(admin_merchant_path(merchant))
    else
      flash.alert = merchant.errors.full_messages.to_sentence
      redirect_to(admin_merchants_path)      
    end
    
  end

  def new
    @merchant = Merchant.new
  end

  def create
    @merchant = Merchant.new(merchant_params)
    if @merchant.save 
      flash.notice = "#{@merchant.name} was successfully added!"
      redirect_to(admin_merchants_path)
    else
      flash.alert = @merchant.errors.full_messages.to_sentence
      render :new
    end
    
  end

  private 

  def merchant_params
    params.require(:merchant).permit(:name, :active_status)
  end
end