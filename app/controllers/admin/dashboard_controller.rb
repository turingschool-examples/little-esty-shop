class Admin::DashboardController < ApplicationController
    def index

      @invoices = Invoice.all
      @incomplete = @invoices.incomplete.distinct
    end

    def show
    end
  end
