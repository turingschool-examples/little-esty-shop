class Admin::MerchantsController < ApplicationController
  before_action :find_merchant, only: [:show, :edit, :update, :update_status]

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
    if @merchant.update!(merchant_params)
      flash[:notice] = "Merchant was successfully update!"

      redirect_to admin_merchant_path(@merchant)
    # *** Waiting on validations to be completed ***
    # else
    #   flash[:notice] = "Error: #{@merchant.errors.full_message.to_senetence}"
    #           ORRRRRRRR
    #   flash[:notice] = "Error: #{error_message(@merchant.errors)}"
    #   render :edit
    end
  end

  def new
    @merchant = Merchnat.new
  end

  def create
    merchant = Merchant.new
    merchant.id = Merchant.new_mechant_id
    merchant.name = params[:name]
    merchant.status = "disable"
    merchant.save!

    redirect_to admin_merchants_path
  end

  def update_status
    if params[:status] == 'enable'
      @merchant.update!(status: 1)
      redirect_to admin_merchants_path
    elsif params[:status] == 'disable'
      @merchant.update!(status: 0)
      redirect_to admin_merchants_path
    end
  end

  private
  def merchant_params
    params.require(:merchant).permit(:name)
  end

  def find_merchant
    @merchant = Merchant.find(params[:id])
  end
end
