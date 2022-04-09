class ItemsController < ApplicationController
  before_action :find_merchant

  def index
    @items = @merchant.items
  end

end
