class Admin::DashboardsController < ApplicationController
  def Index
    require 'pry';binding.pry
    @merchants.find(params[:id])
  end
end