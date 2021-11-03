class AdminsController < ApplicationController
  def dashboard
    @transactions = Transaction.all
    require "pry"; binding.pry
  end
end
