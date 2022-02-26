class Admin::DashboardController < ApplicationController
    def index
      @invoices = Invoice.all
      @incomplete = @invoices.incomplete
    end

    def show
    end
  end
