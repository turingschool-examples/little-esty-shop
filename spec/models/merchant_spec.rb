require 'rails_helper'

RSpec.describe Merchant, type: :model do
  include ActiveSupport:: Testing::TimeHelpers 

  describe 'validations' do
    it { should validate_presence_of(:name) }
    it { should validate_presence_of(:status) }
    it { should define_enum_for(:status) }
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
    describe '#enabled_merchants' do 
      it 'returns only the enabled merchants' do 
        Faker::UniqueGenerator.clear 
        merchant_1 = Merchant.create!(name: Faker::Name.unique.name, status: 1)
        merchant_2 = Merchant.create!(name: Faker::Name.unique.name, status: 1)
        merchant_3 = Merchant.create!(name: Faker::Name.unique.name)
        merchant_4 = Merchant.create!(name: Faker::Name.unique.name, status: 1)

        expect(Merchant.enabled_merchants).to eq([merchant_1, merchant_2, merchant_4])
      end
    end

    describe '#disabled_merchants' do 
      it 'returns only the disabled merchants' do 
        Faker::UniqueGenerator.clear 
        merchant_1 = Merchant.create!(name: Faker::Name.unique.name, status: 1)
        merchant_2 = Merchant.create!(name: Faker::Name.unique.name, status: 1)
        merchant_3 = Merchant.create!(name: Faker::Name.unique.name)
        merchant_4 = Merchant.create!(name: Faker::Name.unique.name, status: 1)

        expect(Merchant.disabled_merchants).to eq([merchant_3])
      end
    end

    describe '#top_5_merchants' do 
      it 'returns the top 5 merchants by total revenue' do
        Faker::UniqueGenerator.clear 

        # merchant_1 with $20 revenue 
        merchant_1 = Merchant.create!(name: Faker::Company.name)
        item_1 = merchant_1.items.create!(name: 'water bottle', description: 'bottle of water', unit_price: 5)
        customer_1 = Customer.create!(first_name: Faker::Name.first_name, last_name: Faker::Name.last_name) 
        invoice_1 = customer_1.invoices.create!(status: 1)
        ii_1a = invoice_1.invoice_items.create!(quantity: 4, unit_price: 5, status: 2, item_id: item_1.id)
        transaction_1 = invoice_1.transactions.create!(credit_card_number: "1234", result: "success")

        # merchant_2 with $44 revenue 
        merchant_2 = Merchant.create!(name: Faker::Company.name)
        item_2a = merchant_2.items.create!(name: 'water bottle2a', description: 'bottle of water', unit_price: 10)
        item_2b = merchant_2.items.create!(name: 'water bottle2b', description: 'bottle of water', unit_price: 1)
        customer_2 = Customer.create!(first_name: Faker::Name.first_name, last_name: Faker::Name.last_name) 
        invoice_2 = customer_2.invoices.create!(status: 1)
        ii_2a = invoice_2.invoice_items.create!(quantity: 4, unit_price: 10, status: 2, item_id: item_2a.id)
        ii_2b = invoice_2.invoice_items.create!(quantity: 4, unit_price: 1, status: 2, item_id: item_2b.id)
        transaction_2 = invoice_2.transactions.create!(credit_card_number: "1234", result: "success")
        
        # merchant_3 with $4 revenue 
        merchant_3 = Merchant.create!(name: Faker::Company.name)
        item_3 = merchant_3.items.create!(name: 'water bottle', description: 'bottle of water', unit_price: 1)
        customer_3 = Customer.create!(first_name: Faker::Name.first_name, last_name: Faker::Name.last_name) 
        invoice_3 = customer_3.invoices.create!(status: 1)
        ii_3a = invoice_3.invoice_items.create!(quantity: 4, unit_price: 1, status: 2, item_id: item_3.id)
        transaction_3 = invoice_3.transactions.create!(credit_card_number: "1234", result: "success")

        # merchant_4 with $30 revenue 
        merchant_4 = Merchant.create!(name: Faker::Company.name)
        item_4 = merchant_4.items.create!(name: 'water bottle', description: 'bottle of water', unit_price: 10)
        customer_4 = Customer.create!(first_name: Faker::Name.first_name, last_name: Faker::Name.last_name) 
        invoice_4 = customer_4.invoices.create!(status: 1)
        ii_4a = invoice_4.invoice_items.create!(quantity: 3, unit_price: 10, status: 2, item_id: item_4.id)
        transaction_4 = invoice_4.transactions.create!(credit_card_number: "1234", result: "success")

        # merchant_5 with $70 revenue 
        merchant_5 = Merchant.create!(name: Faker::Company.name)
        item_5a = merchant_5.items.create!(name: 'water bottle5a', description: 'bottle of water', unit_price: 10)
        item_5b = merchant_5.items.create!(name: 'water bottle5b', description: 'bottle of water', unit_price: 5)
        customer_5 = Customer.create!(first_name: Faker::Name.first_name, last_name: Faker::Name.last_name) 
        invoice_5 = customer_5.invoices.create!(status: 1)
        ii_5a = invoice_5.invoice_items.create!(quantity: 4, unit_price: 10, status: 2, item_id: item_5a.id)
        ii_5b = invoice_5.invoice_items.create!(quantity: 6, unit_price: 5, status: 2, item_id: item_5b.id)
        transaction_5 = invoice_5.transactions.create!(credit_card_number: "1234", result: "success")

        # merchant_6 with $15 revenue 
        merchant_6 = Merchant.create!(name: Faker::Company.name)
        item_6a = merchant_6.items.create!(name: 'water bottle6a', description: 'bottle of water', unit_price: 1)
        item_6b = merchant_6.items.create!(name: 'water bottle6b', description: 'bottle of water', unit_price: 5)
        item_6c = merchant_6.items.create!(name: 'water bottle6c', description: 'bottle of water', unit_price: 7)
        customer_6 = Customer.create!(first_name: Faker::Name.first_name, last_name: Faker::Name.last_name) 
        invoice_6 = customer_6.invoices.create!(status: 1)
        ii_6a = invoice_6.invoice_items.create!(quantity: 3, unit_price: 1, status: 2, item_id: item_6a.id)
        ii_6b = invoice_6.invoice_items.create!(quantity: 1, unit_price: 5, status: 2, item_id: item_6b.id)
        ii_6c = invoice_6.invoice_items.create!(quantity: 1, unit_price: 7, status: 2, item_id: item_6c.id)
        transaction_6 = invoice_6.transactions.create!(credit_card_number: "1234", result: "success")

        # merchant_7 with $0 revenue 
        merchant_7 = Merchant.create!(name: Faker::Company.name)
        item_7a = merchant_7.items.create!(name: 'water bottle6a', description: 'bottle of water', unit_price: 1)
        customer_7 = Customer.create!(first_name: Faker::Name.first_name, last_name: Faker::Name.last_name) 
        invoice_7 = customer_7.invoices.create!(status: 1)
        ii_7a = invoice_7.invoice_items.create!(quantity: 100, unit_price: 1, status: 2, item_id: item_6a.id)
        transaction_7 = invoice_7.transactions.create!(credit_card_number: "1234", result: "failed")

        expect(Merchant.top_5_merchants).to eq([merchant_5, merchant_2, merchant_4, merchant_1, merchant_6])
      end
    end
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

    describe '#top_5_revenue_generated' do
      it 'returns the top 5 revenue generating items for a merchant' do
        @walmart = Merchant.create!(name: "Wal-Mart")

        @pencil = Item.create!( name: "Pencil",
                                description: "Sharpen it and write with it.",
                                unit_price: 199,
                                merchant_id: @walmart.id)

        @marker = Item.create!( name: "Marker",
                                description: "Washable!",
                                unit_price: 159,
                                merchant_id: @walmart.id)

        @eraser = Item.create!( name: "Eraser",
                                description: "Use it to fix mistakes.",
                                unit_price: 205,
                                merchant_id: @walmart.id)

        @ruler = Item.create!(name: "Ruler",
                              description: "It measures things.",
                              unit_price: 105,
                              merchant_id: @walmart.id)

        @folder = Item.create!( name: "Folder",
                                description: "Store stuff in it.",
                                unit_price: 250,
                                merchant_id: @walmart.id)

        @raincoat = Item.create!( name: "Raincoat",
                                  description: "Wear it so you don't get wet.",
                                  unit_price: 5000,
                                  merchant_id: @walmart.id)

        blake = Customer.create!( first_name: "Blake",
                                  last_name: "Saylor")

        invoice_1 = Invoice.create!(status: 1,
                                    customer_id: blake.id)

        invoice_2 = Invoice.create!(status: 1,
                                    customer_id: blake.id)

        invoice_3 = Invoice.create!(status: 1,
                                    customer_id: blake.id)

        invoice_4 = Invoice.create!(status: 1,
                                    customer_id: blake.id)

        invoice_5 = Invoice.create!(status: 1,
                                    customer_id: blake.id)

        invoice_6 = Invoice.create!(status: 1,
                                    customer_id: blake.id)

        invoice_item_1 = InvoiceItem.create!(quantity: 1,
                                              unit_price: 200,
                                              status: 'shipped',
                                              item_id: @pencil.id,
                                              invoice_id: invoice_1.id)

        invoice_item_2 = InvoiceItem.create!(quantity: 2,
                                              unit_price: 300,
                                              status: 'shipped',
                                              item_id: @marker.id,
                                              invoice_id: invoice_2.id)

        invoice_item_3 = InvoiceItem.create!(quantity: 3,
                                              unit_price: 400,
                                              status: 'shipped',
                                              item_id: @eraser.id,
                                              invoice_id: invoice_3.id)

        invoice_item_4 = InvoiceItem.create!(quantity: 4,
                                              unit_price: 500,
                                              status: 'shipped',
                                              item_id: @ruler.id,
                                              invoice_id: invoice_4.id)

        invoice_item_5 = InvoiceItem.create!(quantity: 5,
                                              unit_price: 600,
                                              status: 'shipped',
                                              item_id: @folder.id,
                                              invoice_id: invoice_5.id)

        invoice_item_6 = InvoiceItem.create!(quantity: 6,
                                              unit_price: 700,
                                              status: 'shipped',
                                              item_id: @raincoat.id,
                                              invoice_id: invoice_6.id)

        transaction_1 = Transaction.create!( credit_card_number: '1234',
                                              credit_card_expiration_date: 'never',
                                              result: 'success',
                                              invoice_id: invoice_1.id)

        transaction_2 = Transaction.create!( credit_card_number: '1234',
                                              credit_card_expiration_date: 'never',
                                              result: 'success',
                                              invoice_id: invoice_2.id)

        transaction_3 = Transaction.create!( credit_card_number: '1234',
                                              credit_card_expiration_date: 'never',
                                              result: 'success',
                                              invoice_id: invoice_3.id)

        transaction_4 = Transaction.create!( credit_card_number: '1234',
                                              credit_card_expiration_date: 'never',
                                              result: 'success',
                                              invoice_id: invoice_4.id)

        transaction_5 = Transaction.create!( credit_card_number: '1234',
                                              credit_card_expiration_date: 'never',
                                              result: 'success',
                                              invoice_id: invoice_5.id)

        transaction_6 = Transaction.create!( credit_card_number: '1234',
                                              credit_card_expiration_date: 'never',
                                              result: 'success',
                                              invoice_id: invoice_6.id)
        
        expect(@walmart.items).to eq([@pencil, @marker, @eraser, @ruler, @folder, @raincoat])
        expect(@walmart.top_5_revenue_generated).to eq([@raincoat, @folder, @ruler, @eraser, @marker])
      end
    end

    describe '#best_day' do 
      it 'returns the date with the most revenue for a merchant' do
        Faker::UniqueGenerator.clear 

        # merchant_1 
        merchant_1 = Merchant.create!(name: Faker::Company.name)

        # invoice 1: $20 revenue, 11/24/2004 
        item_1 = merchant_1.items.create!(name: 'water bottle', description: 'bottle of water', unit_price: 5)
        customer_1 = Customer.create!(first_name: Faker::Name.first_name, last_name: Faker::Name.last_name) 
        travel_to Time.zone.local(2004, 11, 24, 1, 4, 44)
        time_2004 = Time.current 
        invoice_1 = customer_1.invoices.create!(status: 1, created_at: time_2004)
        ii_1a = invoice_1.invoice_items.create!(quantity: 4, unit_price: 5, status: 2, item_id: item_1.id)
        transaction_1 = invoice_1.transactions.create!(credit_card_number: "1234", result: "success")

        expect(Merchant.top_5_merchants).to eq([merchant_5, merchant_2, merchant_4, merchant_1, merchant_6])

        # invoice 2: $44 revenue, 9/22/2020
        item_2a = merchant_1.items.create!(name: 'water bottle2a', description: 'bottle of water', unit_price: 10)
        item_2b = merchant_1.items.create!(name: 'water bottle2b', description: 'bottle of water', unit_price: 1)
        customer_2 = Customer.create!(first_name: Faker::Name.first_name, last_name: Faker::Name.last_name) 
        travel_to Time.zone.local(2020, 09, 22, 1, 4, 44)
        time_2020 = Time.current
        invoice_2 = customer_2.invoices.create!(status: 1, created_at: time_2020)
        ii_2a = invoice_2.invoice_items.create!(quantity: 4, unit_price: 10, status: 2, item_id: item_2a.id)
        ii_2b = invoice_2.invoice_items.create!(quantity: 4, unit_price: 1, status: 2, item_id: item_2b.id)
        transaction_2 = invoice_2.transactions.create!(credit_card_number: "1234", result: "success")
        
        # invoice 3: $4 revenue, 1/1/2019
        item_3 = merchant_1.items.create!(name: 'water bottle', description: 'bottle of water', unit_price: 1)
        customer_3 = Customer.create!(first_name: Faker::Name.first_name, last_name: Faker::Name.last_name) 
        trave_to Time.zone.local(2019, 01, 01, 1, 4, 44)
        time_2019 = Time.current
        invoice_3 = customer_3.invoices.create!(status: 1, created_at: time_2019)
        ii_3a = invoice_3.invoice_items.create!(quantity: 4, unit_price: 1, status: 2, item_id: item_3.id)
        transaction_3 = invoice_3.transactions.create!(credit_card_number: "1234", result: "success")

        # invoice 4: $30 revenue, 4/5/2018
        item_4 = merchant_1.items.create!(name: 'water bottle', description: 'bottle of water', unit_price: 10)
        customer_4 = Customer.create!(first_name: Faker::Name.first_name, last_name: Faker::Name.last_name) 
        trave_to Time.zone.local(2018, 04, 05, 1, 4, 44)
        time_2018 = Time.current
        invoice_4 = customer_4.invoices.create!(status: 1, created_at: time_2018)
        ii_4a = invoice_4.invoice_items.create!(quantity: 3, unit_price: 10, status: 2, item_id: item_4.id)
        transaction_4 = invoice_4.transactions.create!(credit_card_number: "1234", result: "success")

        expect(merchant_1.best_day).to eq 9/22/20
      end
    end
  end
end