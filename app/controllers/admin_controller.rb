class AdminController < ApplicationController
  def show
    # repo_name
    @customers = Customer.all
  end
end
