require 'rails_helper'

RSpec.describe "items/index", type: :view do
  before(:each) do
    assign(:items, [
      Item.create!(
        name: "Name",
        merchants: nil,
        description: "MyText",
        unit_price: 2
      ),
      Item.create!(
        name: "Name",
        merchants: nil,
        description: "MyText",
        unit_price: 2
      )
    ])
  end


end
