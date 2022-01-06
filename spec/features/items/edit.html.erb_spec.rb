require 'rails_helper'

RSpec.describe "items/edit", type: :view do
  before(:each) do
    @item = assign(:item, Item.create!(
      name: "MyString",
      merchants: nil,
      description: "MyText",
      unit_price: 1
    ))
  end

end
