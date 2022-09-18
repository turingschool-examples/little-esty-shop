class Admin::AdminController < ApplicationController
  def dashboard
    @top_five_cust = Customer.top_five_cust
    @incomplete = Invoice.incomplete
  end
end
