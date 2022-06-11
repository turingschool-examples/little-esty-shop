class DiscountsController < ApplicationController
  before_action :find_merchant, only: [:index, :show]

  def index
    @discounts = Discount.all
    @holidays = HolidayFacade.get_holidays
  end

  def show
    @discount = Discount.find(params[:id])
  end

  def new
  end
end

# name all facades get_...
# name all services find_...
