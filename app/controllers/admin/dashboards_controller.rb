class Admin::DashboardsController < ApplicationController
  def index
    @customers = Customer.all
    @invoices = Invoice.all
  end

# private
#   def _params
#     params.permit(:)
#   end
end
