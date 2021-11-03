class AdminsController < ApplicationController
  def dashboard
    @transactions = Transaction.all
  end
end
