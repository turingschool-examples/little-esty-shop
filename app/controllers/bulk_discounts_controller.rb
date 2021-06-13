class BulkDiscountsController < ApplicationController
  def index
    @merchant = Merchant.find(params[:merchant_id])
    @discounts = @merchant.bulk_discounts

    response = Faraday.get 'https://date.nager.at/api/v2/NextPublicHolidays/us'
    parsed = JSON.parse(response.body, symbolize_names: true)
    @holidays = parsed[0..2]
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
