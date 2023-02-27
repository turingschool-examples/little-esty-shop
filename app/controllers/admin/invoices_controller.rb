class Admin::InvoicesController < ApplicationController
  def index
    @invoices = Invoice.all
  end

  def show
    @invoice = Invoice.find(params[:id])
  end

  def update
    @invoice = Invoice.find(params[:id])

    @invoice.update(status: params[:invoice][:status])
    redirect_to admin_invoice_path(@invoice)
    flash[:notice] = "Invoice Status has been updated successfully"
    # else
    #   flash[:notice] = "Invoice not updated: Status invalid"
    #   render :show
    # end
  end
end