class AdminController < ApplicationController
  def index
    @customers = Customer.all
  end
end
