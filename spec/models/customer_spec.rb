require 'rails_helper'

RSpec.describe Customer do
  describe 'validations' do
    it { should validate_presence_of(:first_name) }
    it { should validate_presence_of(:last_name) }
  end

  describe 'relationships' do
    it { should have_many :invoices }
  end

  describe "#methods" do
    it 'returns amount of transactions for each customer' do
      merchant_1 = Merchant.create!(name: "Bobs Loggers")
      customer_1 = Customer.create!(first_name: "David", last_name: "Smith")
      item_1 = Item.create!(name: "Log", description: "Wood, maple", unit_price: 500, merchant_id: merchant_1.id )
      invoice_1 = Invoice.create!(status: 2, customer_id: customer_1.id)
      invoice_item_1 = InvoiceItem.create!(quantity: 4, unit_price: 800, status: 2, item_id: item_1.id, invoice_id: invoice_1.id)
      transaction_1 = Transaction.create!(result: 0, invoice_id: invoice_1.id, credit_card_number: "154897654")
      transaction_2 = Transaction.create!(result: 0, invoice_id: invoice_1.id, credit_card_number: "154897654")
      transaction_3 = Transaction.create!(result: 0, invoice_id: invoice_1.id, credit_card_number: "154897654")
      transaction_4 = Transaction.create!(result: 0, invoice_id: invoice_1.id, credit_card_number: "154897654")
      transaction_5 = Transaction.create!(result: 0, invoice_id: invoice_1.id, credit_card_number: "154897654")
      transaction_6 = Transaction.create!(result: 0, invoice_id: invoice_1.id, credit_card_number: "154897654")
      transaction_7 = Transaction.create!(result: 1, invoice_id: invoice_1.id, credit_card_number: "154897654")

      expect(customer_1.successful_transactions).to eq(6)
    end
  end
end