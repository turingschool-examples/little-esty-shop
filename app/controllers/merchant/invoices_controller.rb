class Merchant::InvoicesController < Merchant::BaseController

  def index
    @invoices = Invoice.all
  end

  def show
    @invoice = Invoice.find(params[:id])
  end

  
end