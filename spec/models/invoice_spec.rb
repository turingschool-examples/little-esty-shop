require 'rails_helper'

RSpec.describe Invoice do
  describe 'relationships' do
    it { should belong_to :customer }
    it { should have_many :invoice_items }
    it { should have_many :transactions }
    it { should have_many(:items).through(:invoice_items) }
  end

  describe 'instance methods' do
    it 'can format the created at date' do
      merchant = Merchant.create!(name: 'Trinkets and Tinctures')

      customer1 = Customer.create!(first_name: 'Theophania', last_name: 'Fenwick')

      item1 = merchant.items.create!(name: 'Copper Bracelet', description: 'Shiny, but not too shiny', unit_price: 20)
      item2 = merchant.items.create!(name: 'Copper Ring', description: 'Shiny, but not too shiny', unit_price: 10)
      item3 = merchant.items.create!(name: 'Lemongrass Extract', description: 'Smells citrus', unit_price: 6)

      invoice1 = customer1.invoices.create!(status: 1, created_at: '2022-07-26 01:08:32 UTC')

      invoice_item1 = InvoiceItem.create!(invoice: invoice1, item: item3, quantity: 1, unit_price: 6, status: 1)
      invoice_item2 = InvoiceItem.create!(invoice: invoice1, item: item2, quantity: 1, unit_price: 10, status: 1)

      expect(invoice1.formatted_date).to eq('Tuesday, July 26, 2022')
    end

    it 'can return a string of the customers full name' do
      customer1 = Customer.create!(first_name: 'Theophania', last_name: 'Fenwick')
      invoice1 = customer1.invoices.create!(status: 1, created_at: '2022-07-26 01:08:32 UTC')
      customer2 = Customer.create!(first_name: 'Bob', last_name: 'Schneider')
      invoice2 = customer2.invoices.create!(status: 1, created_at: '2022-07-26 01:08:32 UTC')

      expect(invoice1.customer_name).to eq('Theophania Fenwick')
      expect(invoice2.customer_name).to eq('Bob Schneider')
    end

    it 'can return a list of invoices that have not shipped' do
      # (invoice status 1,2...invoice_item status 0,1)
      merch1 = Merchant.create!(name: 'Potions and Things')
      item1 = merch1.items.create!(name: 'Love Potion', description: 'Wanna smooch you', unit_price: 1350)
      item3 = merch1.items.create!(name: 'Hair of Newt', description: 'Yes, they have hair', unit_price: 350)
      customer1 = Customer.create!(first_name: 'Harry', last_name: 'Potter')
      invoice1 = customer1.invoices.create!(status: 1,created_at: '2022-07-26 01:08:32 UTC')
      invoice2 = customer1.invoices.create!(status: 2,created_at: '2022-07-27 08:08:32 UTC')
      invoice3 = customer1.invoices.create!(status: 0,created_at: '2022-07-20 02:08:32 UTC')
      invoice_item1 = InvoiceItem.create!(invoice: invoice1, item: item1, quantity: 3, unit_price: 750, status: 0)
      invoice_item2 = InvoiceItem.create!(invoice: invoice2, item: item1, quantity: 1, unit_price: 150, status: 2)
      invoice_item3 = InvoiceItem.create!(invoice: invoice3, item: item3, quantity: 5, unit_price: 50, status: 1)
      
      merch2 = Merchant.create!(name: 'Needful Things')
      item3 = merch2.items.create!(name: 'Potion of Haste', description: 'Gotta catch em all!', unit_price: 150)
      item4 = merch2.items.create!(name: 'Veritaserum', description: 'I cannot tell a lie', unit_price: 3450)
      customer2 = Customer.create!(first_name: 'Luna', last_name: 'Lovegood')
      invoice4 = customer2.invoices.create!(status: 1, created_at: '2022-07-26 01:08:32 UTC')
      invoice5 = customer2.invoices.create!(status: 2, created_at: '2022-07-27 08:08:32 UTC')
      invoice6 = customer2.invoices.create!(status: 0, created_at: '2022-07-27 08:08:32 UTC')
      invoice_item4 = InvoiceItem.create!(invoice: invoice4, item: item3, quantity: 3, unit_price: 750, status: 1)
      invoice_item5 = InvoiceItem.create!(invoice: invoice5, item: item3, quantity: 1, unit_price: 150, status: 2)
      invoice_item6 = InvoiceItem.create!(invoice: invoice6, item: item4, quantity: 5, unit_price: 50, status: 0)
      
      invoices = Invoice.invoices_with_items_not_shipped

      # Invoice succeeds, invoice_item succeeds
      expect(invoices.include?(invoice1)).to be(true)
      # Invoice succeeds, invoice_item fails
      expect(invoices.include?(invoice2)).to be(false)
      # Invoice fails, invoice_item succeeds
      expect(invoices.include?(invoice3)).to be(false)

      # invoices succeed, one invoice where invoice succeed, invoice_item fail
      expect(invoices.include?(invoice4)).to be(true)
      expect(invoices.include?(invoice5)).to be(false)
      expect(invoices.include?(invoice6)).to be(false)
    end

    it 'calculates #total_revenue of all items on invoice' do
      merch1 = Merchant.create!(name: 'Needful Things Imports')

      customer1 = Customer.create!(first_name: 'Bob', last_name: 'Schneider')
      customer2 = Customer.create!(first_name: 'Veruca', last_name: 'Salt')

      item1 = merch1.items.create!(name: 'Phoenix Feather Wand', description: 'Ergonomic grip', unit_price: 20)
      item2 = merch1.items.create!(name: 'Harmonica', description: 'Makes pretty noise', unit_price: 6)
      item3 = merch1.items.create!(name: 'Bag of Holding', description: 'This bag has an interior space considerably larger than its outside dimensions, roughly 2 feet in diameter at the mouth and 4 feet deep.', unit_price: 10)
      item4 = merch1.items.create!(name: 'Ring of Resonance', description: 'A ring that resonates with the Ring of Flame Lord', unit_price: 15)
      item5 = merch1.items.create!(name: 'Phreeoni Card', description: 'HIT + 100', unit_price: 20)

      invoice1 = customer1.invoices.create!(status: 1)
      invoice2 = customer2.invoices.create!(status: 1)

      invoice_item1 = InvoiceItem.create!(invoice: invoice1, item: item1, quantity: 1, unit_price: 20, status: 1)
      invoice_item1 = InvoiceItem.create!(invoice: invoice1, item: item2, quantity: 2, unit_price: 6, status: 1)
      invoice_item1 = InvoiceItem.create!(invoice: invoice1, item: item3, quantity: 1, unit_price: 10, status: 1)
      invoice_item2 = InvoiceItem.create!(invoice: invoice2, item: item4, quantity: 2, unit_price: 15, status: 1)
      invoice_item2 = InvoiceItem.create!(invoice: invoice2, item: item5, quantity: 1, unit_price: 20, status: 1)

      expect(invoice1.total_revenue).to eq(42)
    end
    it 'can calculate discounted revenue from bulk discounts' do
      merch1 = Merchant.create!(name: 'Needful Things Imports')
      discount1 = BulkDiscount.create!(merchant_id: merch1.id, percentage: 10, quantity_threshold: 10)
      # discount2 = BulkDiscount.create!(merchant_id: merch1.id, percentage: 5, quantity_threshold: 5)

      customer1 = Customer.create!(first_name: 'Bob', last_name: 'Schneider')
      customer2 = Customer.create!(first_name: 'Veruca', last_name: 'Salt')

      item1 = merch1.items.create!(name: 'Phoenix Feather Wand', description: 'Ergonomic grip', unit_price: 2000)
      item2 = merch1.items.create!(name: 'Harmonica', description: 'Makes pretty noise', unit_price: 600)
      item3 = merch1.items.create!(name: 'Bag of Holding', description: 'This bag has an interior space considerably larger than its outside dimensions, roughly 2 feet in diameter at the mouth and 4 feet deep.', unit_price: 1000)
      item4 = merch1.items.create!(name: 'Ring of Resonance', description: 'A ring that resonates with the Ring of Flame Lord', unit_price: 1500)
      item5 = merch1.items.create!(name: 'Phreeoni Card', description: 'HIT + 100', unit_price: 2000)

      invoice1 = customer1.invoices.create!(status: 1)
      invoice2 = customer2.invoices.create!(status: 1)

      invoice_item1 = InvoiceItem.create!(invoice: invoice1, item: item1, quantity: 10, unit_price: 2000, status: 1) #20000 - 10% is $2000 off
      invoice_item2 = InvoiceItem.create!(invoice: invoice1, item: item2, quantity: 5, unit_price: 600, status: 1) #3000
      invoice_item3 = InvoiceItem.create!(invoice: invoice1, item: item3, quantity: 20, unit_price: 1000, status: 1)#20000 - 10% is $2000 off
      invoice_item4 = InvoiceItem.create!(invoice: invoice2, item: item4, quantity: 2, unit_price: 1500, status: 1)
      invoice_item5 = InvoiceItem.create!(invoice: invoice2, item: item5, quantity: 1, unit_price: 2000, status: 1)
      # binding.pry
      expect(invoice1.total_discounted_revenue).to eq(39000)
    end
  end
end

