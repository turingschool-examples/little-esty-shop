require 'rails_helper'

RSpec.describe "invoices/index", type: :view do
  before(:each) do
    assign(:invoices, [
      Invoice.create!(
        customers: nil,
        status: ""
      ),
      Invoice.create!(
        customers: nil,
        status: ""
      )
    ])
  end

  it "renders a list of invoices" do
    render
    assert_select "tr>td", text: nil.to_s, count: 2
    assert_select "tr>td", text: "".to_s, count: 2
  end
end
