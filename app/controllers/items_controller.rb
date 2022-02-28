class ItemsController < ApplicationController

  def show
    # repo_name
    @item = Item.find(params[:id])
  end

  def update
    # repo_name
    @item = Item.find(params[:id])
    if params[:status] == 'enable'
      @item.update(status: 1)
    elsif params[:status] == 'disable'
      @item.update(status: 0)
    end
    redirect_to "/items/#{@item.id}"
  end

end
