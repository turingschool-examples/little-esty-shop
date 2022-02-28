class AdminController < ApplicationController
  def show
    @customers = Customer.all
  end
end
