class Merchant::DashboardController < ApplicationController

  def index
    @merchant = Merchant.find(params[:merchant_id])
<<<<<<< HEAD
    @top_customers = Customer.top_customers_for_merchant(@merchant.id)
    @pending_items = Item.items_ready_to_ship_by_ordered_date(@merchant.id)
  end

=======
  end
>>>>>>> f29153cf2cbeb386fd0aeb10ebf7f3968d87e0e8
end
