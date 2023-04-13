class AdminController < ApplicationController

  def index
    @customers = Customer.top_5_by_transactions
  end
end
