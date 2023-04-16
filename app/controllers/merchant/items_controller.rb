class Merchant::ItemsController < ApplicationController
  before_action :find_merchant, only: [:index, :show]

  def index
  end

  def show
    @item = @merchant.items.find(params[:id])
  end

  private

  def find_merchant
    @merchant = Merchant.find(params[:merchant_id])
  end
end
