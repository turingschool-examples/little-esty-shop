require 'rails_helper'

RSpec.describe Customer, type: :model do
  let(:customer) { Customer.new(first_name: "Joey", last_name: "T") }

  describe 'relationships' do
    it { should have_many(:invoices) }
    it { should have_many(:transactions).through(:invoices) }
    it { should have_many(:invoice_items).through(:invoices) }
    it { should have_many(:items).through(:invoice_items) }
    it { should have_many(:merchants).through(:items) }
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
      it 'returns the top 5 customers with most succesfully completed transactions' do
        8.times do
          Customer.create!(first_name: Faker::Name.first_name, last_name: Faker::Name.last_name)
        end

        invoice_1 = Invoice.create!(customer_id: Customer.all[0].id, status: 'completed')
        invoice_8 = Invoice.create!(customer_id: Customer.all[0].id, status: 'completed')
        invoice_13 = Invoice.create!(customer_id: Customer.all[0].id, status: 'completed')

        invoice_9 = Invoice.create!(customer_id: Customer.all[1].id, status: 'completed')
        invoice_2 = Invoice.create!(customer_id: Customer.all[1].id, status: 'completed')

        invoice_10 = Invoice.create!(customer_id: Customer.all[2].id, status: 'completed')
        invoice_3 = Invoice.create!(customer_id: Customer.all[2].id, status: 'completed')

        invoice_11 = Invoice.create!(customer_id: Customer.all[3].id, status: 'completed')
        invoice_4 = Invoice.create!(customer_id: Customer.all[3].id, status: 'completed')

        invoice_12 = Invoice.create!(customer_id: Customer.all[4].id, status: 'completed')
        invoice_5 = Invoice.create!(customer_id: Customer.all[4].id, status: 'completed')

        invoice_6 = Invoice.create!(customer_id: Customer.all[5].id, status: 'completed')

        invoice_7 = Invoice.create!(customer_id: Customer.all[6].id, status: 'completed')
        invoice_14 = Invoice.create!(customer_id: Customer.all[6].id, status: 'completed')

        invoice_15 = Invoice.create!(customer_id: Customer.all[7].id, status: 'completed')

        transaction_1 = Transaction.create!(invoice_id: invoice_1.id, credit_card_number: Faker::Number.number(digits: 16), credit_card_expiration_date: '', result: 'success' )
        transaction_2 = Transaction.create!(invoice_id: invoice_2.id, credit_card_number: Faker::Number.number(digits: 16), credit_card_expiration_date: '', result: 'success' )
        transaction_3 = Transaction.create!(invoice_id: invoice_3.id, credit_card_number: Faker::Number.number(digits: 16), credit_card_expiration_date: '', result: 'success' )
        transaction_4 = Transaction.create!(invoice_id: invoice_4.id, credit_card_number: Faker::Number.number(digits: 16), credit_card_expiration_date: '', result: 'success' )
        transaction_5 = Transaction.create!(invoice_id: invoice_5.id, credit_card_number: Faker::Number.number(digits: 16), credit_card_expiration_date: '', result: 'success' )
        transaction_6 = Transaction.create!(invoice_id: invoice_6.id, credit_card_number: Faker::Number.number(digits: 16), credit_card_expiration_date: '', result: 'success' )
        transaction_7 = Transaction.create!(invoice_id: invoice_7.id, credit_card_number: Faker::Number.number(digits: 16), credit_card_expiration_date: '', result: 'success' )
        transaction_8 = Transaction.create!(invoice_id: invoice_8.id, credit_card_number: Faker::Number.number(digits: 16), credit_card_expiration_date: '', result: 'success' )
        transaction_9 = Transaction.create!(invoice_id: invoice_9.id, credit_card_number: Faker::Number.number(digits: 16), credit_card_expiration_date: '', result: 'success' )
        transaction_10 = Transaction.create!(invoice_id: invoice_10.id, credit_card_number: Faker::Number.number(digits: 16), credit_card_expiration_date: '', result: 'success' )
        transaction_11 = Transaction.create!(invoice_id: invoice_11.id, credit_card_number: Faker::Number.number(digits: 16), credit_card_expiration_date: '', result: 'success' )
        transaction_12 = Transaction.create!(invoice_id: invoice_12.id, credit_card_number: Faker::Number.number(digits: 16), credit_card_expiration_date: '', result: 'success' )
        transaction_13 = Transaction.create!(invoice_id: invoice_13.id, credit_card_number: Faker::Number.number(digits: 16), credit_card_expiration_date: '', result: 'failed' )
        transaction_14 = Transaction.create!(invoice_id: invoice_14.id, credit_card_number: Faker::Number.number(digits: 16), credit_card_expiration_date: '', result: 'failed' )
        transaction_15 = Transaction.create!(invoice_id: invoice_15.id, credit_card_number: Faker::Number.number(digits: 16), credit_card_expiration_date: '', result: 'success' )

        expect(Customer.top_customers).to eq([Customer.all[0], Customer.all[1], Customer.all[2], Customer.all[3], Customer.all[4]])
      end
    end
  end
end