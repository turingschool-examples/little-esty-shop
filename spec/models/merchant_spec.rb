require 'rails_helper'

RSpec.describe Merchant do
  describe 'relationships' do
    it { should have_many(:items) }
  end

  describe 'validations' do
    it { should validate_presence_of(:name) }
  end

  describe 'intance methods' do
    xit 'can find the five favorite customers' do
      customer_1 = Customer.create!(first_name: 'Weston', last_name: 'Ellis')
      customer_2 = Customer.create!(first_name: 'Larry', last_name: 'Davit')
      customer_3 = Customer.create!(first_name: 'Billy', last_name: 'Eylish')
      customer_4 = Customer.create!(first_name: 'Harry', last_name: 'Langnif')
      customer_5 = Customer.create!(first_name: 'Bill', last_name: 'Barry')
      customer_6 = Customer.create!(first_name: 'Ted', last_name: 'Staros')
      customer_7 = Customer.create!(first_name: 'JJ', last_name: 'I dont know her last name')

      invoice_1 = customer_1.invoices.create!(status: 2)
      invoice_2 = customer_2.invoices.create!(status: 2)
      invoice_3 = customer_3.invoices.create!(status: 2)
      invoice_4 = customer_4.invoices.create!(status: 2)
      invoice_5 = customer_5.invoices.create!(status: 2)
      invoice_6 = customer_6.invoices.create!(status: 2)

      transaction_1 = invoice_1.transactions.create!(credit_card_number: 123, result: 'success')
      transaction_2 = invoice_2.transactions.create!(credit_card_number: 123, result: 'success')
      transaction_3 = invoice_3.transactions.create!(credit_card_number: 123, result: 'success')
      transaction_4 = invoice_4.transactions.create!(credit_card_number: 123, result: 'success')
      transaction_5 = invoice_5.transactions.create!(credit_card_number: 123, result: 'success')
      #tests for failed/success
      transaction_6 = invoice_6.transactions.create!(credit_card_number: 123, result: 'failed')
      transaction_7 = invoice_6.transactions.create!(credit_card_number: 123, result: 'failed')

      merchant =  Merchant.create!(name: "Bob's Best")

      item = merchant.items.create!(name: 'coffee', description: 'iz cool', unit_price: 5000)

      InvoiceItem.create!(item: item, invoice: invoice_1, quantity: 100, unit_price: 100, status: 2)
      InvoiceItem.create!(item: item, invoice: invoice_2, quantity: 100, unit_price: 100, status: 2)
      InvoiceItem.create!(item: item, invoice: invoice_3, quantity: 100, unit_price: 100, status: 2)
      InvoiceItem.create!(item: item, invoice: invoice_4, quantity: 100, unit_price: 100, status: 2)
      InvoiceItem.create!(item: item, invoice: invoice_5, quantity: 100, unit_price: 100, status: 2)
      InvoiceItem.create!(item: item, invoice: invoice_6, quantity: 100, unit_price: 100, status: 2)

      expect(merchant.five_best_customers).to eq([customer_1, customer_2, customer_3, customer_4, customer_5])
    end
  end

  describe 'class methods' do
    it 'can fetch enabled merchants' do
      merchant_1 = create(:merchant, status: true)
      merchant_2 = create(:merchant, status: false)

      expect(Merchant.enabled_merchants).to eq([merchant_1])
    end

    it 'can fetch disabled merchants' do
      merchant_1 = create(:merchant, status: true)
      merchant_2 = create(:merchant, status: false)

      expect(Merchant.enabled_merchants).to eq([merchant_1])
    end
  end
end
