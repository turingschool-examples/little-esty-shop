class Admin::DashboardsController < ApplicationController
  def index
    @customers = Customer.all
  end

# private
#   def _params
#     params.permit(:)
#   end
end
