require 'rails_helper'

RSpec.describe Merchant do
  describe 'relationships' do
    it { should have_many(:items) }
  end

  describe 'validations' do
    it { should validate_presence_of(:name) }
  end

  describe 'intance methods' do
    it 'can find the five favorite customers' do
      customer_1 = Customer.create!(first_name: 'Weston', last_name: 'Ellis')
      customer_2 = Customer.create!(first_name: 'Larry', last_name: 'Davit')
      customer_3 = Customer.create!(first_name: 'Billy', last_name: 'Eylish')
      customer_4 = Customer.create!(first_name: 'Harry', last_name: 'Langnif')
      customer_5 = Customer.create!(first_name: 'Bill', last_name: 'Barry')
      customer_6 = Customer.create!(first_name: 'Ted', last_name: 'Staros')

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

      item.transactions << transaction_1
      item.transactions << transaction_2
      item.transactions << transaction_3
      item.transactions << transaction_4
      item.transactions << transaction_5
      item.transactions << transaction_6
      item.transactions << transaction_7

      expect(merchant.five_best_customers).to eq([customer_1, customer_2, customer_3, customer_4, customer_5])
    end
  end
end

# As an admin,
# When I visit the admin dashboard
# Then I see the names of the top 5 customers
# who have conducted the largest number of successful transactions
# And next to each customer name I see the number of successful transactions they have
# conducted with my merchant
