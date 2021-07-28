require 'rails_helper'

RSpec.describe Customer do
  describe 'relationships' do
    it {should have_many :invoices}
    it {should have_many(:transactions).through(:invoices)}
  end

  describe 'class methods' do
    describe '#top_five' do
      it 'returns the top 5 customers name with revenue' do
        merchant = Merchant.create!(name:'Bobby Crafts')
        item = merchant.items.create!(name: "Foot Creame", description: "Please Not This", unit_price: 1350)
        customer = Customer.create!(first_name: 'Sally', last_name: 'Mendez')
        customer2 = Customer.create!(first_name: 'Sammy', last_name: 'Smith')
        customer3 = Customer.create!(first_name: 'Trevor', last_name: 'William')
        customer4 = Customer.create!(first_name: 'Drew', last_name: 'Hammond')
        customer5 = Customer.create!(first_name: 'Justin', last_name: 'Mcafee')
        customer6 = Customer.create!(first_name: 'Aaron', last_name: 'Jones')

        invoice = Invoice.create!(customer_id: customer.id, status: 'completed')
        invoice2 = Invoice.create!(customer_id: customer2.id, status: 'completed')
        invoice3 = Invoice.create!(customer_id: customer2.id, status: 'completed')
        invoice4 = Invoice.create!(customer_id: customer3.id, status: 'completed')
        invoice5 = Invoice.create!(customer_id: customer4.id, status: 'completed')
        invoice6 = Invoice.create!(customer_id: customer5.id, status: 'completed')
        invoice7 = Invoice.create!(customer_id: customer6.id, status: 'completed')

        InvoiceItem.create!(item_id: item.id, invoice_id: invoice.id, quantity: 539, unit_price: 13635, status: 1)
        InvoiceItem.create!(item_id: item.id, invoice_id: invoice2.id, quantity: 539, unit_price: 13635, status: 1)
        InvoiceItem.create!(item_id: item.id, invoice_id: invoice3.id, quantity: 539, unit_price: 13635, status: 1)
        InvoiceItem.create!(item_id: item.id, invoice_id: invoice4.id, quantity: 539, unit_price: 13635, status: 1)
        InvoiceItem.create!(item_id: item.id, invoice_id: invoice5.id, quantity: 539, unit_price: 13635, status: 1)
        InvoiceItem.create!(item_id: item.id, invoice_id: invoice6.id, quantity: 539, unit_price: 13635, status: 1)

        invoice.transactions.create!(credit_card_number: 465440541, credit_card_expiration_date: nil, result: 'success')
        invoice.transactions.create!(credit_card_number: 465440542, credit_card_expiration_date: nil, result: 'success')
        invoice.transactions.create!(credit_card_number: 465440543, credit_card_expiration_date: nil, result: 'success')
        invoice2.transactions.create!(credit_card_number: 465440541, credit_card_expiration_date: nil, result: 'success')
        invoice2.transactions.create!(credit_card_number: 465440542, credit_card_expiration_date: nil, result: 'success')
        invoice2.transactions.create!(credit_card_number: 465440543, credit_card_expiration_date: nil, result: 'success')
        invoice2.transactions.create!(credit_card_number: 465440541, credit_card_expiration_date: nil, result: 'success')
        invoice2.transactions.create!(credit_card_number: 465440542, credit_card_expiration_date: nil, result: 'success')
        invoice2.transactions.create!(credit_card_number: 465440543, credit_card_expiration_date: nil, result: 'success')
        invoice3.transactions.create!(credit_card_number: 465440541, credit_card_expiration_date: nil, result: 'success')
        invoice4.transactions.create!(credit_card_number: 465440541, credit_card_expiration_date: nil, result: 'success')
        invoice4.transactions.create!(credit_card_number: 465440542, credit_card_expiration_date: nil, result: 'success')
        invoice5.transactions.create!(credit_card_number: 465440541, credit_card_expiration_date: nil, result: 'success')
        invoice5.transactions.create!(credit_card_number: 465440542, credit_card_expiration_date: nil, result: 'success')
        invoice5.transactions.create!(credit_card_number: 465440543, credit_card_expiration_date: nil, result: 'success')
        invoice5.transactions.create!(credit_card_number: 465440541, credit_card_expiration_date: nil, result: 'success')
        invoice6.transactions.create!(credit_card_number: 465440541, credit_card_expiration_date: nil, result: 'success')
        invoice6.transactions.create!(credit_card_number: 465440542, credit_card_expiration_date: nil, result: 'success')
        invoice6.transactions.create!(credit_card_number: 465440543, credit_card_expiration_date: nil, result: 'success')
        invoice7.transactions.create!(credit_card_number: 465440541, credit_card_expiration_date: nil, result: 'success')
        invoice7.transactions.create!(credit_card_number: 465440542, credit_card_expiration_date: nil, result: 'success')

        best_customers = Customer.merchant_top_five(merchant.id)

        expect(best_customers[0].full_name).to eq('Sammy Smith')
      end
    end
  end
end
