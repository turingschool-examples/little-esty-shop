require 'rails_helper'

RSpec.describe "transactions/new", type: :view do
  before(:each) do
    assign(:transaction, Transaction.new(
      invoices: nil,
      credit_card_number: 1,
      result: 1
    ))
  end

end
