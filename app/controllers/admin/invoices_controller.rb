class Admin::InvoicesController < ApplicationController

  def index
    @invoices = Invoice.all
  end

  def show
    @invoice = Invoice.find(params[:id])
  end

  def new
  end

  def edit
    @invoice = Invoice.find(params[:id])
  end

  def create
  end

  def update
  end

end