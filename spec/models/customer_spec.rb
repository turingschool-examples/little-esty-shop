require 'rails_helper'

RSpec.describe Customer, type: :model do
  describe 'relationships' do
    it { should have_many :invoices }
  end

  describe '::top_customers' do
    it 'should return the top customers by succesfull transactions' do
      customer1 = Customer.create!(first_name: "Bob", last_name: "Dylan")
      customer2 = Customer.create!(first_name: "Micha", last_name: "B")
      customer3 = Customer.create!(first_name: "Christian", last_name: "V")
      invoice1 = Invoice.create!(customer_id: customer1.id, status: 'completed')
      invoice2 = Invoice.create!(customer_id: customer1.id, status: 'completed')
      invoice3 = Invoice.create!(customer_id: customer1.id, status: 'completed')
      invoice4 = Invoice.create!(customer_id: customer2.id, status: 'completed')
      invoice5 = Invoice.create!(customer_id: customer2.id, status: 'completed')
      invoice6 = Invoice.create!(customer_id: customer3.id, status: 'completed')
      invoice7 = Invoice.create!(customer_id: customer3.id, status: 'completed')
      transaction1 = Transaction.create!(invoice_id: invoice1.id, credit_card_number: 123, credit_card_expiration_date: nil, result: 'success')
      transaction2 = Transaction.create!(invoice_id: invoice2.id, credit_card_number: 123, credit_card_expiration_date: nil, result: 'success')
      transaction3 = Transaction.create!(invoice_id: invoice3.id, credit_card_number: 123, credit_card_expiration_date: nil, result: 'success')
      transaction4 = Transaction.create!(invoice_id: invoice4.id, credit_card_number: 123, credit_card_expiration_date: nil, result: 'success')
      transaction5 = Transaction.create!(invoice_id: invoice5.id, credit_card_number: 123, credit_card_expiration_date: nil, result: 'success')
      transaction6 = Transaction.create!(invoice_id: invoice6.id, credit_card_number: 123, credit_card_expiration_date: nil, result: 'success')
      transaction7 = Transaction.create!(invoice_id: invoice7.id, credit_card_number: 123, credit_card_expiration_date: nil, result: 'failed')
      transaction8 = Transaction.create!(invoice_id: invoice1.id, credit_card_number: 123, credit_card_expiration_date: nil, result: 'success')
      
      expect(Customer.top_customers).to eq([["#{customer1.first_name} #{customer1.last_name}", 4], ["#{customer2.first_name} #{customer2.last_name}", 2], ["#{customer3.first_name} #{customer3.last_name}", 1]])
    end
  end
end
