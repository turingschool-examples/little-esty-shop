require 'rails_helper'

RSpec.describe Customer, type: :model do
  describe 'relationships' do

    it {should have_many(:invoices)}

  end

  describe 'class methods' do
    it 'shows top customers' do
      customer1 = Customer.create!(first_name: 'Gunther', last_name: 'Guyman')
      customer2 = Customer.create!(first_name: 'Miles', last_name: 'Prower')
      customer3 = Customer.create!(first_name: 'Mario', last_name: 'Mario')
      customer4 = Customer.create!(first_name: 'Marneus', last_name: 'Calgar')
      customer5 = Customer.create!(first_name: 'Sol', last_name: 'Badguy')
      customer6 = Customer.create!(first_name: 'Wyatt', last_name: 'Kribs')

      invoice1 = Invoice.create!(customer_id: customer1.id, status: 2)
      invoice2 = Invoice.create!(customer_id: customer2.id, status: 2)
      invoice3 = Invoice.create!(customer_id: customer3.id, status: 2)
      invoice4 = Invoice.create!(customer_id: customer4.id, status: 2)
      invoice5 = Invoice.create!(customer_id: customer5.id, status: 2)

      transaction1 = Transaction.create!(invoice_id: invoice1.id, credit_card_number: 12345, result: 1)
      transaction2 = Transaction.create!(invoice_id: invoice2.id, credit_card_number: 12345, result: 1)
      transaction3 = Transaction.create!(invoice_id: invoice3.id, credit_card_number: 12345, result: 1)
      transaction4 = Transaction.create!(invoice_id: invoice4.id, credit_card_number: 12345, result: 1)
      transaction5 = Transaction.create!(invoice_id: invoice5.id, credit_card_number: 12345, result: 1)

      expect(Customer.top_customers).to eq([customer1, customer2, customer3, customer4, customer5])
    end
  end

  describe 'instance methods' do

    it 'shows number of transactions' do
      customer = Customer.create!(first_name: 'Gunther', last_name: 'Guyman')

      invoice1 = Invoice.create!(customer_id: customer.id, status: 2)
      invoice2 = Invoice.create!(customer_id: customer.id, status: 2)

      transaction1 = Transaction.create!(invoice_id: invoice1.id, credit_card_number: 12345, result: 1)
      transaction2 = Transaction.create!(invoice_id: invoice2.id, credit_card_number: 12345, result: 1)

      expect(customer.number_of_transactions).to eq(2)
    end
  end
end
