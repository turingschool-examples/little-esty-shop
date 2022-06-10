class DiscountsController < ApplicationController

  def index
    @holidays = HolidayFacade.get_holidays
  end
end

# name all facades get_...
# name all services find_...
