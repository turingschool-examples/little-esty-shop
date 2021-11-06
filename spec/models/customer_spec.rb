require 'rails_helper'

RSpec.describe Customer, type: :model do
  describe 'relationships' do
    it {should have_many :invoices}
  end

  it 'counts how many successful transactions a customer has' do
    customer = Customer

    expect(customer.successful_transactions_count).to eq(7)
  end
end
