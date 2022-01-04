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

  xit "renders the edit item form" do
    render

    assert_select "form[action=?][method=?]", item_path(@item), "post" do

      assert_select "input[name=?]", "item[name]"

      assert_select "input[name=?]", "item[merchants_id]"

      assert_select "textarea[name=?]", "item[description]"

      assert_select "input[name=?]", "item[unit_price]"
    end
  end
end
