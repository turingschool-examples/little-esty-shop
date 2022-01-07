class Admin::BaseController < ApplicationController

  def index
    @invoices = Invoice.all
  end
end
