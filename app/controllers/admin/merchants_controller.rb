class Admin::MerchantsController < ApplicationController
  def index
    @info = GithubInfo.new
    @merchants = Merchant.all
  end

  def show
    @info = GithubInfo.new
    @merchant = Merchant.find(params[:id])
  end

  def edit
    @info = GithubInfo.new
    @merchant = Merchant.find(params[:id])
  end

  def update
    merchant = Merchant.find(params[:id])

    merchant.update!(merchant_params)

    return redirect_to admin_merchants_path if params[:merchant][:enabled]

    redirect_to admin_merchant_path(merchant)
    flash[:notice] = 'Merchant name has been changed'
  end

  def new
    @info = GithubInfo.new
    @merchant = Merchant.new
  end

  def create
    Merchant.create!(merchant_params)

    redirect_to admin_merchants_path
  end

  private

  def merchant_params
    params.require(:merchant).permit(:name, :enabled)
  end
end
