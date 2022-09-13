require "rails_helper"

RSpec.describe(Transaction, type: :model) do
  let(:transaction) { Transaction.new(invoice_id: 1, credit_card_number: 4654405418249632, credit_card_expiration_date: '', result: 'success') }

  it("is an instance of transaction") do
    expect(transaction).to(be_instance_of(Transaction))
  end
end