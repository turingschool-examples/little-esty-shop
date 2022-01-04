require 'rails_helper'

RSpec.describe "items/new", type: :view do
  before(:each) do
    assign(:item, Item.new(
      name: "MyString",
      merchants: nil,
      description: "MyText",
      unit_price: 1
    ))
  end
end
