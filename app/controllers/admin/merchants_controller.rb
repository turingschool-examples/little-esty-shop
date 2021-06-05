class Admin::MerchantsController < ApplicationController
  before_action :find_merchant, only: [:show, :edit, :update]

  def index
    @merchants = Merchant.all
    @enabled_merchants = Merchant.enabled
    @disabled_merchants = Merchant.disabled
    @top_merchants_by_revenue = Merchant.top_merchants_by_revenue
  end

  def show
  end

  def edit
  end

  def update
    if !@merchant.update(merchant_params)
      flash.now[:alert] = "Error: #{@merchant.errors.full_messages.to_sentence}"
      render :edit
    elsif @merchant.update!(merchant_params)
     flash[:notice] = "Merchant was successfully update!"
     redirect_to admin_merchant_path(@merchant)
    end
  end

  def new
    @merchant = Merchant.new
  end

  def create
    if params[:status]
      @merchant = Merchant.find(params[:merchant])
      @merchant.status = params[:status]
    else
      merchant = Merchant.new
      merchant.id = Merchant.new_mechant_id
      merchant.name = params[:merchant][:name]
      merchant.status = params[:merchant][:status]
      merchant.save!

      redirect_to admin_merchants_path
    end
  end

  private
  def merchant_params
    params.require(:merchant).permit(:name, :status)
  end

  def find_merchant
    @merchant = Merchant.find(params[:id])
  end
end
