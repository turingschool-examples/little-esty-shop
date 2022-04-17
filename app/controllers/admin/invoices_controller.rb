class Admin::InvoicesController < ApplicationController
  def index
  end

  def show 
    binding.pry
    @invoice = Invoice.find(params[:id])
  end 
end
