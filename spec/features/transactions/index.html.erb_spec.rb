require 'rails_helper'

RSpec.describe "transactions/index", type: :view do
  before(:each) do
    assign(:transactions, [
      Transaction.create!(
        invoices: nil,
        credit_card_number: 2,
        result: 3
      ),
      Transaction.create!(
        invoices: nil,
        credit_card_number: 2,
        result: 3
      )
    ])
  end

  
end
