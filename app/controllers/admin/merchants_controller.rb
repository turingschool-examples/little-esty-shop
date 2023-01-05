module Admin
  class MerchantsController < ApplicationController
    def index
      @merchants = Merchant.all
    end
  end
end