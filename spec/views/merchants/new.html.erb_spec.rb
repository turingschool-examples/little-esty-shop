require 'rails_helper'

RSpec.describe "merchants/new", type: :view do
  before(:each) do
    assign(:merchant, Merchant.new(
      name: "MyString"
    ))
  end

  it "renders new merchant form" do
    render

    assert_select "form[action=?][method=?]", merchants_path, "post" do

      assert_select "input[name=?]", "merchant[name]"
    end
  end
end
