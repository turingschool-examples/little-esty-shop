require 'rails_helper'

RSpec.describe Customer, type: :model do
  let(:customer) { Customer.new(first_name: "Joey", last_name: "T") }

  describe 'relationships' do
    it {should have_many(:invoices)}
  end

  describe 'validations' do
    it {should validate_presence_of(:first_name)}
    it {should validate_presence_of(:last_name)}
  end

  it 'is an instance of customer' do
    expect(customer).to be_instance_of(Customer)
  end

  describe 'class methods' do
    describe 'top_customers' do
      xit 'returns the top 5 customers with most succesfully completed transactions' do
        customer_1 = Customer.create!(first_name: 'Sandy', last_name: 'Busch')
        customer_2 = Customer.create!(first_name: 'Josh', last_name: 'Mann')
        customer_3 = Customer.create!(first_name: 'Miya', last_name: 'Yang')
        customer_4 = Customer.create!(first_name: 'Angel', last_name: 'Olsen')
        customer_5 = Customer.create!(first_name: 'Max', last_name: 'Smelter')
        customer_6 = Customer.create!(first_name: 'Bobby', last_name: 'Brown')
        customer_7 = Customer.create!(first_name: 'Jessica', last_name: 'Alba') 

        invoice_1 = Invoice.create!(customer_id: customer_1.id, status: 'completed')
        invoice_8 = Invoice.create!(customer_id: customer_1.id, status: 'completed')
        invoice_13 = Invoice.create!(customer_id: customer_1.id, status: 'completed')

        invoice_9 = Invoice.create!(customer_id: customer_2.id, status: 'completed')
        invoice_2 = Invoice.create!(customer_id: customer_2.id, status: 'completed')

        invoice_10 = Invoice.create!(customer_id: customer_3.id, status: 'completed')
        invoice_3 = Invoice.create!(customer_id: customer_3.id, status: 'completed')

        invoice_11 = Invoice.create!(customer_id: customer_4.id, status: 'completed')
        invoice_4 = Invoice.create!(customer_id: customer_4.id, status: 'completed')

        invoice_12 = Invoice.create!(customer_id: customer_5.id, status: 'completed')
        invoice_5 = Invoice.create!(customer_id: customer_5.id, status: 'completed')

        invoice_6 = Invoice.create!(customer_id: customer_6.id, status: 'completed')

        invoice_7 = Invoice.create!(customer_id: customer_7.id, status: 'completed')
        invoice_14 = Invoice.create!(customer_id: customer_7.id, status: 'completed')


        transaction_1 = Transaction.create!(invoice_id: invoice_1.id, credit_card_number: 4654405418249632, credit_card_expiration_date: '', result: 'success' )
        transaction_2 = Transaction.create!(invoice_id: invoice_2.id, credit_card_number: 4654405428249632, credit_card_expiration_date: '', result: 'success' )
        transaction_3 = Transaction.create!(invoice_id: invoice_3.id, credit_card_number: 4654405415249632, credit_card_expiration_date: '', result: 'success' )
        transaction_4 = Transaction.create!(invoice_id: invoice_4.id, credit_card_number: 4654405411249632, credit_card_expiration_date: '', result: 'success' )
        transaction_5 = Transaction.create!(invoice_id: invoice_5.id, credit_card_number: 4654405238249632, credit_card_expiration_date: '', result: 'success' )
        transaction_6 = Transaction.create!(invoice_id: invoice_6.id, credit_card_number: 4654405898249632, credit_card_expiration_date: '', result: 'success' )
        transaction_7 = Transaction.create!(invoice_id: invoice_7.id, credit_card_number: 4654405408249632, credit_card_expiration_date: '', result: 'success' )
        transaction_8 = Transaction.create!(invoice_id: invoice_8.id, credit_card_number: 4654405412249632, credit_card_expiration_date: '', result: 'success' )
        transaction_9 = Transaction.create!(invoice_id: invoice_9.id, credit_card_number: 4654405408249552, credit_card_expiration_date: '', result: 'success' )
        transaction_10 = Transaction.create!(invoice_id: invoice_10.id, credit_card_number: 2654405408249632, credit_card_expiration_date: '', result: 'success' )
        transaction_11 = Transaction.create!(invoice_id: invoice_11.id, credit_card_number: 1654405408249632, credit_card_expiration_date: '', result: 'success' )
        transaction_12 = Transaction.create!(invoice_id: invoice_12.id, credit_card_number: 6654405408249632, credit_card_expiration_date: '', result: 'success' )
        transaction_13 = Transaction.create!(invoice_id: invoice_13.id, credit_card_number: 6654405408209632, credit_card_expiration_date: '', result: 'failed' )
        transaction_14 = Transaction.create!(invoice_id: invoice_14.id, credit_card_number: 9654405408209632, credit_card_expiration_date: '', result: 'failed' )

        expect(Customer.top_customers).to eq([@customer_1, @customer_2, @customer_3, @customer_4, @customer_5])
      end
    end
  end
end