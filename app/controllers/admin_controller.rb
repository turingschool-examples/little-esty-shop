class AdminController < ApplicationController
  def index
  end

  def merchants
    @merchants = Merchant.all
  end

  def invoices
  end
end
