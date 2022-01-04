require 'rails_helper'

RSpec.describe "items/show", type: :view do
  before(:each) do
    @item = assign(:item, Item.create!(
      name: "Name",
      merchants: nil,
      description: "MyText",
      unit_price: 2
    ))
  end

  
end
