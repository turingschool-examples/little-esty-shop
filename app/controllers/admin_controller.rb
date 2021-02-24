class AdminController < ApplicationController
  def index
    @transactions = Transaction.all
  end
end