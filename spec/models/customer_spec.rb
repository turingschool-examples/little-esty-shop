require 'rails_helper'

RSpec.describe Customer, type: :model do
  describe 'relationships' do
    it {should have_many :invoices}
  end

  it 'counts how many successful transactions a customer has' do
    customer = create(:customer)
    invoice1 = create(:invoice, customer: customer)
    invoice2 = create(:invoice, customer: customer)
    invoice3 = create(:invoice, customer: customer)

    create(:transaction, result: 'success', invoice: invoice1)
    create(:transaction, result: 'success', invoice: invoice1)
    create(:transaction, result: 'success', invoice: invoice2)
    create(:transaction, result: 'failed', invoice: invoice2)
    create(:transaction, result: 'failed', invoice: invoice3)

    expect(customer.successful_transactions_count).to eq(3)
  end
end
