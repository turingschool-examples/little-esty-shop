class BulkDiscountsController < ApplicationController
  def index
    @merchant = Merchant.find(params[:merchant_id])
    @discounts = @merchant.bulk_discounts

    response = Faraday.get 'https://date.nager.at/api/v1/Get/US/2021'
    parsed = JSON.parse(response.body, symbolize_names: true)
    [:name][:date]
  end

  def show
    @merchant = Merchant.find(params[:merchant_id])
    @discount = BulkDiscount.find(params[:id])
  end

  def new

  end

  def create

  end

  def edit

  end

  def update

  end

  def destroy

  end

  # private
  # def _params
  #   params.permit(:)
  # end
end
