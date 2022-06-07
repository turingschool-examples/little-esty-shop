class AdminsController < ApplicationController

  def dashboard
    @customers = Customer.all
  end

end
