require 'rails_helper'

RSpec.describe "merchants/index", type: :view do
  before(:each) do
    assign(:merchants, [
      Merchant.create!(
        name: "Name"
      ),
      Merchant.create!(
        name: "Name"
      )
    ])
  end

  it "renders a list of merchants" do
    render
    assert_select "tr>td", text: "Name".to_s, count: 2
  end
end
