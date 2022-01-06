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

  xit "renders new item form" do
    render

    assert_select "form[action=?][method=?]", items_path, "post" do

      assert_select "input[name=?]", "item[name]"

      assert_select "input[name=?]", "item[merchants_id]"

      assert_select "textarea[name=?]", "item[description]"

      assert_select "input[name=?]", "item[unit_price]"
    end
  end
end
