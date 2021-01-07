class InvoicesController < ApplicationController

  def index
    @invoice = Invoice.all
  end
end
