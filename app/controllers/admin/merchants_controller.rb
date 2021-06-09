class Admin::MerchantsController < ApplicationController
  def index
    @merchants = Merchant.all

    @enable = @merchants.where('status = ?', 'enable')
    @disable = @merchants.where('status = ?', 'disable')
    @top_five = Merchant.top_five_by_successful_transaction
  end

  def show
    @merchant = Merchant.find(params[:id])
  end

  def new
  end

  def edit
    @merchant = Merchant.find(params[:id])
  end

  def update
    @merchant = Merchant.find(params[:id])

    @merchant.update(merchant_params)

    redirect_to "/admin/merchants/#{@merchant.id}"
    flash[:notice] = 'Successfully Updated'
  end

  def update_status
    if params.include?('enable')
      merchant = Merchant.find(params[:merchant_id])

      merchant.update(status: 'enable')

      redirect_to "/admin/merchants"
    elsif params.include?('disable')
      merchant = Merchant.find(params[:merchant_id])

      merchant.update(status: 'disable')

      redirect_to "/admin/merchants"
    end
  end

  def create
    Merchant.create!(name: params[:name], status: 'disable')

    redirect_to '/admin/merchants'
  end
end

private

  def merchant_params
    params.permit(:name)
  end
