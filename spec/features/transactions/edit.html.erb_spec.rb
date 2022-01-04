require 'rails_helper'

RSpec.describe "transactions/edit", type: :view do
  before(:each) do
    @transaction = assign(:transaction, Transaction.create!(
      invoices: nil,
      credit_card_number: 1,
      result: 1
    ))
  end

  it "renders the edit transaction form" do
    render

    assert_select "form[action=?][method=?]", transaction_path(@transaction), "post" do

      assert_select "input[name=?]", "transaction[invoices_id]"

      assert_select "input[name=?]", "transaction[credit_card_number]"

      assert_select "input[name=?]", "transaction[result]"
    end
  end
end
