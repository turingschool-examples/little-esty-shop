require 'time'
class MerchantDashboardController < ApplicationController
  def index
    @merchant = Merchant.find(params[:merchant_id])
    @customers = Customer.top_five_customers
    @invoice_items_to_ship = @merchant.unshipped_invoice_items

  end

  helper_method :date_formatter

  def date_formatter(date_obj)
    formatted = date_obj.strftime("%A, %B %d, %Y")
  end

end
