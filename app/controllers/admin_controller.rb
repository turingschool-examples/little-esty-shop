class AdminController < ApplicationController

  def index
    @top_5_customers = Customer.top_five_overall_cust
  end

end