require 'rails_helper'

RSpec.describe "invoices/edit", type: :view do
  before(:each) do
    @invoice = assign(:invoice, Invoice.create!(
      customers: nil,
      status: ""
    ))
  end

  xit "renders the edit invoice form" do
    render

    assert_select "form[action=?][method=?]", invoice_path(@invoice), "post" do

      assert_select "input[name=?]", "invoice[customers_id]"

      assert_select "input[name=?]", "invoice[status]"
    end
  end
end
