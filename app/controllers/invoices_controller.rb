#placeholder - can delete or edit and use
class InvoicesController < ApplicationController
  def index
    @invoices = Invoice.all
  end
end