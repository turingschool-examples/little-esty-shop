require 'rails_helper'

RSpec.describe "invoices/new", type: :view do
  before(:each) do
    assign(:invoice, Invoice.new(
      customers: nil,
      status: ""
    ))
  end

  it "renders new invoice form" do
    render

    assert_select "form[action=?][method=?]", invoices_path, "post" do

      assert_select "input[name=?]", "invoice[customers_id]"

      assert_select "input[name=?]", "invoice[status]"
    end
  end
end
