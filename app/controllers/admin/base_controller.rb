class Admin::BaseController < ApplicationController
    def show
      @customers = Customer.all
    end
end