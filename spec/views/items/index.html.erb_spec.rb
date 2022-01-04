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

  xit "renders a list of items" do
    render
    assert_select "tr>td", text: "Name".to_s, count: 2
    assert_select "tr>td", text: nil.to_s, count: 2
    assert_select "tr>td", text: "MyText".to_s, count: 2
    assert_select "tr>td", text: 2.to_s, count: 2
  end
end
