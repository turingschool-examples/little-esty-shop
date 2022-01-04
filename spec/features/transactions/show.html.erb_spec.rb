require 'rails_helper'

RSpec.describe "transactions/show", type: :view do
  before(:each) do
    @transaction = assign(:transaction, Transaction.create!(
      invoices: nil,
      credit_card_number: 2,
      result: 3
    ))
  end

  
end
