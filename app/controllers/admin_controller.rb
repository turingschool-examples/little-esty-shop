class AdminController < ApplicationController
 def index
  @not_shipped = Invoice.not_shipped
  @merchants = Merchant.all
  end
end
