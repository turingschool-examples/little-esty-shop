class Admin::BaseController < ApplicationController
    def show
      @customers = Customer.all
      @invoices = Invoice.all
    end
end
