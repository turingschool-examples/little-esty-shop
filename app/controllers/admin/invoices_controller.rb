module Admin  
  class InvoicesController < ApplicationController

    def index 
      @invoices = Invoice.all
    end
  end
end 