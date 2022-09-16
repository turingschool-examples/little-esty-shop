class Admin::AdminController < ApplicationController
  def dashboard
    @top_five_cust = Customer.top_five_cust
  end
end
