#placeholder - can delete or edit and use
class ItemsController < ApplicationController
  def index
    @items = Item.all
  end

end