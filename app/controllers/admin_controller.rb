class AdminController < ApplicationController
 def index
  @not_shipped = Invoice.not_shipped
  end
end
