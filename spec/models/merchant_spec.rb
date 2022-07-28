require 'rails_helper'

RSpec.describe Merchant, type: :model do
  describe 'validations' do
    it { should validate_presence_of(:name) }
  end

  describe 'relationships' do
    it { should have_many :items }
    it { should have_many(:invoice_items).through (:items) }
    it { should have_many(:invoices).through(:invoice_items) }
    it { should have_many(:transactions).through(:invoices)}
    it { should have_many(:customers).through(:invoices)}
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
        transaction_6a_6 = invoice_6a.transactions.create!(credit_card_number: '7890', result: 'success')

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
        transaction_7a_7 = invoice_7a.transactions.create!(credit_card_number: '8901', result: 'success')

        # binding.pry 

        expect(merchant_1.top_5).to eq([customer_7, customer_6, customer_1, customer_2, customer_4])
      end
    end

    describe '#unshipped_items' do 
      it 'returns a list of items that have been ordered and not yet shipped' do 
        Item.destroy_all
        merchant_1 = Merchant.create!(name: 'Mike Dao')

        item_1 = merchant_1.items.create!(name: 'Book of Rails', description: 'book on rails', unit_price: 2000)
        item_2 = merchant_1.items.create!(name: 'Dog Scratcher', description: 'scratches dogs', unit_price: 800)
        item_3 = merchant_1.items.create!(name: 'Dog Water Bottle', description: 'dogs can drink from it', unit_price: 1600)
        item_4 = merchant_1.items.create!(name: 'Turtle Stickers', description: 'stickers of turtles', unit_price: 400)

        # customer_1 
        customer_1 = Customer.create!(first_name: 'Anna Marie', last_name: 'Sterling')

        invoice_1a = customer_1.invoices.create!(status: 1)

        ii1 = InvoiceItem.create!(quantity: 2, unit_price: item_1.unit_price, status: 'packaged', item: item_1, invoice: invoice_1a)
        ii2 = InvoiceItem.create!(quantity: 2, unit_price: item_2.unit_price, status: 'packaged', item: item_2, invoice: invoice_1a)
        ii3 = InvoiceItem.create!(quantity: 2, unit_price: item_3.unit_price, status: 'packaged', item: item_3, invoice: invoice_1a)


        invoice_1b = customer_1.invoices.create!(status: 0)
        ii4 = InvoiceItem.create!(quantity: 2, unit_price: item_2.unit_price, status: 'packaged', item: item_2, invoice: invoice_1b)
        ii5 = InvoiceItem.create!(quantity: 2, unit_price: item_3.unit_price, status: 'packaged', item: item_3, invoice: invoice_1b)
        ii6 = InvoiceItem.create!(quantity: 2, unit_price: item_4.unit_price, status: 'shipped', item: item_4, invoice: invoice_1b)

        expect(merchant_1.unshipped_items).to contain_exactly(ii1, ii2, ii3, ii4, ii5)
      end 

    it 'should return invoice_items associated with a merchant' do
      merchant = Merchant.create!(name: 'amazon')
      merchant_2 = Merchant.create!(name: 'Gucci')
      customer = Customer.create!(first_name: 'Billy', last_name: 'Bob')
      item_1 = Item.create!(name: 'pet rock', description: 'a rock you pet', unit_price: 10000, merchant_id: merchant.id)
      item_2 = Item.create!(name: 'ferbie', description: 'monster toy', unit_price: 66600, merchant_id: merchant.id)
      item_3 = Item.create!(name: 'bay blade', description: 'let it rip!', unit_price: 23400, merchant_id: merchant_2.id)
      invoice_1 = Invoice.create!(status: 'completed', customer_id: customer.id)

      in_items_1 = InvoiceItem.create!(quantity: 2121, unit_price: 12345, status: 'shipped', item: item_1, invoice: invoice_1)
      in_items_2 = InvoiceItem.create!(quantity: 234, unit_price: 2353456, status: 'packaged', item: item_2, invoice: invoice_1)
      in_items_3 = InvoiceItem.create!(quantity: 2345, unit_price: 2353, status: 'packaged', item: item_3, invoice: invoice_1)

      expect(merchant.get_invoice_items(invoice_1.id)).to eq([in_items_1,in_items_2])
      expect(merchant.get_invoice_items(invoice_1.id)).to_not eq([in_items_3])
    end

    it 'should return total revenue from a invoice' do
      merchant = Merchant.create!(name: 'amazon')
      customer = Customer.create!(first_name: 'Billy', last_name: 'Bob')
      item_1 = Item.create!(name: 'pet rock', description: 'a rock you pet', unit_price: 10000, merchant_id: merchant.id)
      item_2 = Item.create!(name: 'ferbie', description: 'monster toy', unit_price: 66600, merchant_id: merchant.id)
      invoice_1 = Invoice.create!(status: 'completed', customer_id: customer.id)


      InvoiceItem.create!(quantity: 20, unit_price: 10, status: 'shipped', item: item_1, invoice: invoice_1)
      InvoiceItem.create!(quantity: 10, unit_price: 500, status: 'packaged', item: item_2, invoice: invoice_1)

      expect(merchant.total_revenue(invoice_1.id)).to eq(5200)
    end
  end
end