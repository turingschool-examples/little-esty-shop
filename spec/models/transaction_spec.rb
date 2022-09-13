require 'rails_helper'

RSpec.describe Transaction, type: :model do
  describe 'relationships' do

    it {should belong_to(:invoice)}

  end

  describe 'enums' do
    it 'responds to status updates' do
      customer = Customer.create!(first_name: "Gunther", last_name: "Guyman")
      invoice = Invoice.create!(customer_id: customer.id, status: 0)
      transaction = Transaction.create!(invoice_id: invoice.id, credit_card_number: "59829292157329", result: 0)

      expect(transaction.failed?).to eq(true)

      transaction.success!
      expect(transaction.failed?).to eq(false)
    end
  end
end
