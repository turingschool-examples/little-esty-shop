require 'rails_helper'

RSpec.describe Merchant, type: :model do
  describe 'validations' do
    it { should validate_presence_of(:name) }
  end

  describe 'relationships' do
    it { should have_many :items }
    it { should have_many(:invoices).through(:items)}
    it { should have_many(:transactions).through(:invoices)}
  end

  before :each do
  end

  describe 'class methods' do
    
  end

  describe 'instance methods' do
    describe '#top_5' do 
      it 'returns the top 5 customers who have conducted the largest number of successful transactions with my merchant' do 
        Transaction.destroy_all
        merchant_1 = Merchant.create!(name: 'Mike Dao')

        item_1 = merchant_1.items.create!(name: 'Book of Rails', description: 'book on rails', unit_price: 2000)
        item_2 = merchant_1.items.create!(name: 'Dog Scratcher', description: 'scratches dogs', unit_price: 800)
        item_3 = merchant_1.items.create!(name: 'Dog Water Bottle', description: 'dogs can drink from it', unit_price: 1600)
        item_4 = merchant_1.items.create!(name: 'Turtle Stickers', description: 'stickers of turtles', unit_price: 400)

        # customer_1 
        customer_1 = Customer.create!(first_name: 'Anna Marie', last_name: 'Sterling')

        invoice_1a = customer_1.invoices.create!(status: 1)

        InvoiceItem.create!(quantity: 2, unit_price: item_1.unit_price, status: 'shipped', item: item_1, invoice: invoice_1a)
        InvoiceItem.create!(quantity: 2, unit_price: item_2.unit_price, status: 'shipped', item: item_2, invoice: invoice_1a)
        InvoiceItem.create!(quantity: 2, unit_price: item_3.unit_price, status: 'shipped', item: item_3, invoice: invoice_1a)
        InvoiceItem.create!(quantity: 2, unit_price: item_4.unit_price, status: 'shipped', item: item_4, invoice: invoice_1a)

        # transaction_1a_1 = Transaction.create!(credit_card_number: '1234', result: 'success', invoice_id: invoice_1a.id)

        transaction_1a_1 = invoice_1a.transactions.create!(credit_card_number: '1234', result: 'success')
        transaction_1a_2 = invoice_1a.transactions.create!(credit_card_number: '1234', result: 'success')
        transaction_1a_3 = invoice_1a.transactions.create!(credit_card_number: '1234', result: 'success')
        transaction_1a_4 = invoice_1a.transactions.create!(credit_card_number: '1234', result: 'success')

        invoice_1b = customer_1.invoices.create!(status: 1)

        InvoiceItem.create!(quantity: 2, unit_price: item_1.unit_price, status: 'shipped', item: item_1, invoice: invoice_1b)
        
        transaction_1b_1 = invoice_1b.transactions.create!(credit_card_number: '1234', result: 'success')

        # customer_2 

        customer_2 = Customer.create!(first_name: 'Carlos', last_name: 'Stich')

        invoice_2a = customer_2.invoices.create!(status: 1) 

        InvoiceItem.create!(quantity: 2, unit_price: item_1.unit_price, status: 'shipped', item: item_1, invoice: invoice_2a)
        InvoiceItem.create!(quantity: 2, unit_price: item_2.unit_price, status: 'shipped', item: item_2, invoice: invoice_2a)
        InvoiceItem.create!(quantity: 2, unit_price: item_3.unit_price, status: 'shipped', item: item_3, invoice: invoice_2a)
        InvoiceItem.create!(quantity: 2, unit_price: item_4.unit_price, status: 'shipped', item: item_4, invoice: invoice_2a)

        transaction_2a_1 = invoice_2a.transactions.create!(credit_card_number: '2345', result: 'success')
        transaction_2a_2 = invoice_2a.transactions.create!(credit_card_number: '2345', result: 'success')
        transaction_2a_3 = invoice_2a.transactions.create!(credit_card_number: '2345', result: 'success')
        transaction_2a_4 = invoice_2a.transactions.create!(credit_card_number: '2345', result: 'success')

        # customer_3

        customer_3 = Customer.create!(first_name: 'Bob', last_name: 'Builder')

        invoice_3a = customer_3.invoices.create!(status: 2)

        InvoiceItem.create!(quantity: 2, unit_price: item_1.unit_price, status: 'shipped', item: item_1, invoice: invoice_3a)

        transaction_3a_1 = invoice_3a.transactions.create!(credit_card_number: '3456', result: 'failed')

        # customer_4 

        customer_4 = Customer.create!(first_name: 'Cindy', last_name: 'Crawford')

        invoice_4a = customer_4.invoices.create!(status: 1)

        InvoiceItem.create!(quantity: 2, unit_price: item_1.unit_price, status: 'shipped', item: item_1, invoice: invoice_4a)
        InvoiceItem.create!(quantity: 2, unit_price: item_2.unit_price, status: 'shipped', item: item_2, invoice: invoice_4a)
        InvoiceItem.create!(quantity: 2, unit_price: item_3.unit_price, status: 'shipped', item: item_3, invoice: invoice_4a)

        transaction_4a_1 = invoice_4a.transactions.create!(credit_card_number: '5678', result: 'success')
        transaction_4a_2 = invoice_4a.transactions.create!(credit_card_number: '5678', result: 'success')
        transaction_4a_3 = invoice_4a.transactions.create!(credit_card_number: '5678', result: 'success')

        # customer_5

        customer_5 = Customer.create!(first_name: 'Gigi', last_name: 'Hadid')
        invoice_5a = customer_5.invoices.create!(status: 1)
        InvoiceItem.create!(quantity: 2, unit_price: item_1.unit_price, status: 'shipped', item: item_1, invoice: invoice_5a)
        transaction_5a_1 = invoice_5a.transactions.create!(credit_card_number: '6789', result: 'success')

        # customer_6

        customer_6 = Customer.create!(first_name: 'Jessie', last_name: 'J')
        invoice_6a = customer_6.invoices.create!(status: 1)

        InvoiceItem.create!(quantity: 2, unit_price: item_1.unit_price, status: 'shipped', item: item_1, invoice: invoice_6a)
        InvoiceItem.create!(quantity: 2, unit_price: item_2.unit_price, status: 'shipped', item: item_2, invoice: invoice_6a)
        InvoiceItem.create!(quantity: 2, unit_price: item_3.unit_price, status: 'shipped', item: item_3, invoice: invoice_6a)
        InvoiceItem.create!(quantity: 2, unit_price: item_4.unit_price, status: 'shipped', item: item_4, invoice: invoice_6a)
        InvoiceItem.create!(quantity: 3, unit_price: item_1.unit_price, status: 'shipped', item: item_1, invoice: invoice_6a)

        transaction_6a_1 = invoice_6a.transactions.create!(credit_card_number: '7890', result: 'success')
        transaction_6a_2 = invoice_6a.transactions.create!(credit_card_number: '7890', result: 'success')
        transaction_6a_3 = invoice_6a.transactions.create!(credit_card_number: '7890', result: 'success')
        transaction_6a_4 = invoice_6a.transactions.create!(credit_card_number: '7890', result: 'success')
        transaction_6a_5 = invoice_6a.transactions.create!(credit_card_number: '7890', result: 'success')

        # customer_7

        customer_7 = Customer.create!(first_name: 'Channing', last_name: 'Tatum')
        invoice_7a = customer_7.invoices.create!(status: 1)

        InvoiceItem.create!(quantity: 2, unit_price: item_1.unit_price, status: 'shipped', item: item_1, invoice: invoice_7a)
        InvoiceItem.create!(quantity: 2, unit_price: item_2.unit_price, status: 'shipped', item: item_2, invoice: invoice_7a)
        InvoiceItem.create!(quantity: 2, unit_price: item_3.unit_price, status: 'shipped', item: item_3, invoice: invoice_7a)
        InvoiceItem.create!(quantity: 2, unit_price: item_4.unit_price, status: 'shipped', item: item_4, invoice: invoice_7a)
        InvoiceItem.create!(quantity: 3, unit_price: item_1.unit_price, status: 'shipped', item: item_1, invoice: invoice_7a)
        InvoiceItem.create!(quantity: 3, unit_price: item_2.unit_price, status: 'shipped', item: item_2, invoice: invoice_7a)

        transaction_7a_1 = invoice_7a.transactions.create!(credit_card_number: '8901', result: 'success')
        transaction_7a_2 = invoice_7a.transactions.create!(credit_card_number: '8901', result: 'success')
        transaction_7a_3 = invoice_7a.transactions.create!(credit_card_number: '8901', result: 'success')
        transaction_7a_4 = invoice_7a.transactions.create!(credit_card_number: '8901', result: 'success')
        transaction_7a_5 = invoice_7a.transactions.create!(credit_card_number: '8901', result: 'success')
        transaction_7a_6 = invoice_7a.transactions.create!(credit_card_number: '8901', result: 'success')

        # binding.pry 

        expect(merchant_1.top_5).to eq([customer_7, customer_6, customer_1, customer_2, customer_4])
      end
    end
  end
end