class Admin::MerchantsController < ApplicationController
  before_action :find_merchant, only: [:show, :edit, :update]

  def index
    @merchants = Merchant.all
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

  private
  def merchant_params
    params.require(:merchant).permit(:name)
  end

  def find_merchant
    @merchant = Merchant.find(params[:id])
  end
end
