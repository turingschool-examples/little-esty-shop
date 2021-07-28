class Admin::InvoicesController < ApplicationController

  def index
    @invoices = Invoice.all
  end

  def show
    require "pry"; binding.pry
    @invoices = Invoice.find(params[:id])
   
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