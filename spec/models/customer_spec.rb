require 'rails_helper'

RSpec.describe Customer, type: :model do

  describe 'validations' do
    it { should validate_presence_of :first_name }
    it { should validate_presence_of :last_name}
    # it { should validate_presence_of :created_at}
    # it { should validate_presence_of :updated_at}
  end

  describe 'relationships' do
    it { should have_many :invoices }
  end

  it 'returns the top 5 customers with the highest number of successful transactions' do
    merchant = Merchant.create!(name: "Josey Wales")

    item_1 = Item.create!(name: "Moonshine", description: "alcohol", unit_price: 2, merchant_id: merchant.id)

    customer_1 = Customer.create!(first_name: "Babe", last_name: "Ruth")
    customer_2 = Customer.create!(first_name: "Charles", last_name: "Bukowski")
    customer_3 = Customer.create!(first_name: "Al", last_name: "Capone")
    customer_4 = Customer.create!(first_name: "Popcorn", last_name: "Sutton")
    customer_5 = Customer.create!(first_name: "Nucky", last_name: "Johnson")
    customer_6 = Customer.create!(first_name: "Freddy", last_name: "McCoy")
    customer_7 = Customer.create!(first_name: "Ted", last_name: "Williams")

    invoice_1 = Invoice.create!(status: 0, customer_id: customer_1.id)
    invoice_2 = Invoice.create!(status: 0, customer_id: customer_2.id)
    invoice_3 = Invoice.create!(status: 0, customer_id: customer_3.id)
    invoice_4 = Invoice.create!(status: 0, customer_id: customer_4.id)
    invoice_5 = Invoice.create!(status: 0, customer_id: customer_5.id)
    invoice_6 = Invoice.create!(status: 0, customer_id: customer_6.id)

    transaction_1 = Transaction.create!(credit_card_number: "1234", credit_card_expiration_date: "042023", result: "success", invoice_id: invoice_1.id)
    transaction_2 = Transaction.create!(credit_card_number: "1234", credit_card_expiration_date: "042023", result: "success", invoice_id: invoice_1.id)
    transaction_3 = Transaction.create!(credit_card_number: "1234", credit_card_expiration_date: "042023", result: "success", invoice_id: invoice_1.id)
    transaction_4 = Transaction.create!(credit_card_number: "1234", credit_card_expiration_date: "042023", result: "success", invoice_id: invoice_1.id)
    transaction_5 = Transaction.create!(credit_card_number: "1234", credit_card_expiration_date: "042023", result: "success", invoice_id: invoice_1.id)
    transaction_6 = Transaction.create!(credit_card_number: "5678", credit_card_expiration_date: "052023", result: "success", invoice_id: invoice_2.id)
    transaction_7 = Transaction.create!(credit_card_number: "5678", credit_card_expiration_date: "052023", result: "success", invoice_id: invoice_2.id)
    transaction_8 = Transaction.create!(credit_card_number: "5678", credit_card_expiration_date: "052023", result: "success", invoice_id: invoice_2.id)
    transaction_9 = Transaction.create!(credit_card_number: "5678", credit_card_expiration_date: "052023", result: "success", invoice_id: invoice_2.id)
    transaction_10 = Transaction.create!(credit_card_number: "9012", credit_card_expiration_date: "062023", result: "success", invoice_id: invoice_3.id)
    transaction_11 = Transaction.create!(credit_card_number: "9012", credit_card_expiration_date: "062023", result: "success", invoice_id: invoice_3.id)
    transaction_12 = Transaction.create!(credit_card_number: "9012", credit_card_expiration_date: "062023", result: "success", invoice_id: invoice_3.id)
    transaction_13 = Transaction.create!(credit_card_number: "3456", credit_card_expiration_date: "072023", result: "success", invoice_id: invoice_4.id)
    transaction_14 = Transaction.create!(credit_card_number: "3456", credit_card_expiration_date: "072023", result: "success", invoice_id: invoice_4.id)
    transaction_15 = Transaction.create!(credit_card_number: "3456", credit_card_expiration_date: "082023", result: "success", invoice_id: invoice_5.id)
    transaction_16 = Transaction.create!(credit_card_number: "3456", credit_card_expiration_date: "092023", result: "success", invoice_id: invoice_6.id)

    invoice_item_1 = InvoiceItem.create!(quantity: 1, unit_price: 2, status: 0, item_id: item_1.id, invoice_id: invoice_1.id)
    invoice_item_2 = InvoiceItem.create!(quantity: 1, unit_price: 2, status: 1, item_id: item_1.id, invoice_id: invoice_2.id)
    invoice_item_3 = InvoiceItem.create!(quantity: 1, unit_price: 2, status: 0, item_id: item_1.id, invoice_id: invoice_3.id)
    invoice_item_4 = InvoiceItem.create!(quantity: 1, unit_price: 2, status: 2, item_id: item_1.id, invoice_id: invoice_4.id)
    invoice_item_5 = InvoiceItem.create!(quantity: 1, unit_price: 2, status: 0, item_id: item_1.id, invoice_id: invoice_5.id)

    expected_top_5_customers = [customer_1, customer_2, customer_3, customer_4, customer_5]

    expect(Customer.top_five_customers_by_transaction(merchant.id)).to eq(expected_top_5_customers)
  end
end
