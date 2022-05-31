class InvoicesController < ApplicationController
  before_action :find_merchant

  def index
    @invoices = Invoice.all
  end
end
