require 'rails_helper'

RSpec.describe "transactions/new", type: :view do
  before(:each) do
    assign(:transaction, Transaction.new(
      invoices: nil,
      credit_card_number: 1,
      result: 1
    ))
  end

  xit "renders new transaction form" do
    render

    assert_select "form[action=?][method=?]", transactions_path, "post" do

      assert_select "input[name=?]", "transaction[invoices_id]"

      assert_select "input[name=?]", "transaction[credit_card_number]"

      assert_select "input[name=?]", "transaction[result]"
    end
  end
end
