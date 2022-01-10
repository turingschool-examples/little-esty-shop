class Admin::AdminController < ApplicationController
  def index
    @customers = Customer.all
  end
end
