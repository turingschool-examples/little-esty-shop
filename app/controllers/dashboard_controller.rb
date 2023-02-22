class DashboardController < MerchantsController
  def index
    @merchant = Merchant.find(params[:id])
  end
end