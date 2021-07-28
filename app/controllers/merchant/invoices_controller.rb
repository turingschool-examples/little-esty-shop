class Merchant::InvoicesController < ApplicationController

  def index
    @merchant_invoices = Invoice.all
    #helper method for invoices specific to merchant
  end

  def show
    #merchant specific invoice
  end

  def new
  end

  def edit
  end

  def create
  end

  def update
  end

end