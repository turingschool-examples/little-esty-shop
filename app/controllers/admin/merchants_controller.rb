class Admin::MerchantsController < ApplicationController
  def index
    @merchants = Merchant.all
    @top_5_by_revenue = Merchant.top_5_by_revenue
  end

  def show
    @merchant = Merchant.find(params[:id])
  end

  def edit
    @merchant = Merchant.find(params[:id])
  end

  def update
    @merchant = Merchant.find(params[:id])
    edit_form_submission
  end

  def edit_form_submission
    if params[:commit] == 'Update'
      if @merchant.update(merchant_params)
        flash[:notice] = 'Merchant updated successfully!'
        redirect_to admin_merchant_path(@merchant)
      else
        flash[:alert] = "Error: #{@merchant.errors.full_messages}"
        redirect_to edit_admin_merchant_path(@merchant)
      end
    end
  end

  private

  def merchant_params
    params.permit(:name)
  end
end
