require 'rails_helper'

RSpec.describe Item do
  describe 'validations' do
    it { should validate_presence_of(:name) }
    it { should validate_presence_of(:description) }
    it { should validate_presence_of(:unit_price) }
  end

  describe 'relationships' do
    it { should belong_to :merchant }
    it { should have_many :invoice_items }
    it { should have_many(:invoices).through(:invoice_items) }
    it { should have_many(:transactions).through(:invoices) }
    it { should have_many(:customers).through(:invoices) }
  end

  describe '#methods' do
    it 'returns the quantity of an item ordered from invoice item' do
      merchant_1 = Merchant.create!(name: "Bobs Loggers")
      item_1 = Item.create!(name: "Log", description: "Wood, maple", unit_price: 500, merchant_id: merchant_1.id )
      customer_1 = Customer.create!(first_name: "David", last_name: "Smith")
      invoice_1 = Invoice.create!(status: 0, customer_id: customer_1.id)
      invoice_item_1 = InvoiceItem.create!(quantity: 4, unit_price: 800, status: 0, item_id: item_1.id, invoice_id: invoice_1.id)

      expect(item_1.quantity_ordered(invoice_1)).to eq(4)
    end

    it 'returns the unit_price of an item ordered from invoice item' do
      merchant_1 = Merchant.create!(name: "Bobs Loggers")
      item_1 = Item.create!(name: "Log", description: "Wood, maple", unit_price: 500, merchant_id: merchant_1.id )
      customer_1 = Customer.create!(first_name: "David", last_name: "Smith")
      invoice_1 = Invoice.create!(status: 0, customer_id: customer_1.id)
      invoice_item_1 = InvoiceItem.create!(quantity: 4, unit_price: 800, status: 0, item_id: item_1.id, invoice_id: invoice_1.id)

      expect(item_1.price_sold(invoice_1)).to eq(800)
    end

    it 'returns the status of an item ordered from invoice item' do
      merchant_1 = Merchant.create!(name: "Bobs Loggers")
      item_1 = Item.create!(name: "Log", description: "Wood, maple", unit_price: 500, merchant_id: merchant_1.id )
      customer_1 = Customer.create!(first_name: "David", last_name: "Smith")
      invoice_1 = Invoice.create!(status: 0, customer_id: customer_1.id)
      invoice_item_1 = InvoiceItem.create!(quantity: 4, unit_price: 800, status: 0, item_id: item_1.id, invoice_id: invoice_1.id)

      expect(item_1.item_status(invoice_1)).to eq("pending")
    end

    it 'returns the date with the most sales for that item' do
      merchant_1 = Merchant.create!(name: "Bobs Loggers")

      item_1 = Item.create!(name: 'Spatula', description: 'It is for cooking', unit_price: 3, merchant_id: merchant_1.id)
      item_2 = Item.create!(name: 'Spoon', description: 'It is for eating ice cream', unit_price: 1, merchant_id: merchant_1.id)
      item_3 = Item.create!(name: 'Knife', description: 'It is for slicing bread', unit_price: 5, merchant_id: merchant_1.id)
      item_4 = Item.create!(name: 'Computer', description: 'It is for playing games', unit_price: 50, merchant_id: merchant_1.id)
      item_5 = Item.create!(name: 'Table', description: 'It is for eating at', unit_price: 70, merchant_id: merchant_1.id)
      item_6 = Item.create!(name: 'Bag of Money', description: 'It is for whatever you want', unit_price: 999, merchant_id: merchant_1.id)
      
      customer_1 = Customer.create!(first_name: "David", last_name: "Smith")
      
      invoice_1 = Invoice.create!(status: 2, customer_id: customer_1.id, created_at: "Sat, 30 Jul 2022 16:04:49 UTC +00:00")
      invoice_2 = Invoice.create!(status: 2, customer_id: customer_1.id, created_at: "Sat, 30 Jul 2022 16:04:49 UTC +00:00")
      invoice_3 = Invoice.create!(status: 2, customer_id: customer_1.id, created_at: "Sat, 30 Jul 2022 16:04:49 UTC +00:00")
      invoice_10 = Invoice.create!(status: 2, customer_id: customer_1.id, created_at: "Fri, 29 Jul 2022 16:04:49 UTC +00:00")

      invoice_4 = Invoice.create!(status: 2, customer_id: customer_1.id, created_at: "Fri, 29 Jul 2022 16:04:49 UTC +00:00")
      invoice_5 = Invoice.create!(status: 2, customer_id: customer_1.id, created_at: "Fri, 29 Jul 2022 16:04:49 UTC +00:00")
      invoice_11 = Invoice.create!(status: 2, customer_id: customer_1.id, created_at: "Sat, 30 Jul 2022 16:04:49 UTC +00:00")

      invoice_6 = Invoice.create!(status: 2, customer_id: customer_1.id, created_at: "Sat, 30 Jul 2022 16:04:49 UTC +00:00")
      invoice_12 = Invoice.create!(status: 2, customer_id: customer_1.id, created_at: "Sat, 30 Jul 2022 16:04:49 UTC +00:00")
      invoice_13 = Invoice.create!(status: 2, customer_id: customer_1.id, created_at: "Fri, 29 Jul 2022 16:04:49 UTC +00:00")

      invoice_7 = Invoice.create!(status: 2, customer_id: customer_1.id, created_at: "Sat, 30 Jul 2022 16:04:49 UTC +00:00")
      invoice_14 = Invoice.create!(status: 2, customer_id: customer_1.id, created_at: "Fri, 29 Jul 2022 16:04:49 UTC +00:00")
      invoice_15 = Invoice.create!(status: 2, customer_id: customer_1.id, created_at: "Fri, 29 Jul 2022 16:04:49 UTC +00:00")

      invoice_8 = Invoice.create!(status: 2, customer_id: customer_1.id, created_at: "Sat, 30 Jul 2022 16:04:49 UTC +00:00")
      invoice_16 = Invoice.create!(status: 2, customer_id: customer_1.id, created_at: "Sat, 30 Jul 2022 16:04:49 UTC +00:00")
      invoice_17 = Invoice.create!(status: 2, customer_id: customer_1.id, created_at: "Fri, 29 Jul 2022 16:04:49 UTC +00:00")

      invoice_9 = Invoice.create!(status: 2, customer_id: customer_1.id, created_at: "Sat, 30 Jul 2022 16:04:49 UTC +00:00")
      invoice_18 = Invoice.create!(status: 2, customer_id: customer_1.id, created_at: "Fri, 29 Jul 2022 16:04:49 UTC +00:00")
      invoice_19 = Invoice.create!(status: 2, customer_id: customer_1.id, created_at: "Fri, 29 Jul 2022 16:04:49 UTC +00:00")

      invoice_item_1 = InvoiceItem.create!(quantity: 4, unit_price: 800, status: 2, item_id: item_1.id, invoice_id: invoice_1.id)
      invoice_item_2 = InvoiceItem.create!(quantity: 5, unit_price: 900, status: 2, item_id: item_1.id, invoice_id: invoice_2.id)
      invoice_item_3 = InvoiceItem.create!(quantity: 5, unit_price: 900, status: 2, item_id: item_1.id, invoice_id: invoice_3.id)
      invoice_item_4 = InvoiceItem.create!(quantity: 5, unit_price: 900, status: 2, item_id: item_1.id, invoice_id: invoice_10.id)

      invoice_item_5 = InvoiceItem.create!(quantity: 5, unit_price: 900, status: 2, item_id: item_2.id, invoice_id: invoice_4.id)
      invoice_item_6 = InvoiceItem.create!(quantity: 5, unit_price: 900, status: 2, item_id: item_2.id, invoice_id: invoice_5.id)
      invoice_item_7 = InvoiceItem.create!(quantity: 5, unit_price: 900, status: 2, item_id: item_2.id, invoice_id: invoice_11.id)

      invoice_item_8 = InvoiceItem.create!(quantity: 5, unit_price: 900, status: 2, item_id: item_3.id, invoice_id: invoice_6.id)
      invoice_item_8 = InvoiceItem.create!(quantity: 5, unit_price: 900, status: 2, item_id: item_3.id, invoice_id: invoice_12.id)
      invoice_item_8 = InvoiceItem.create!(quantity: 5, unit_price: 900, status: 2, item_id: item_3.id, invoice_id: invoice_13.id)

      invoice_item_9 = InvoiceItem.create!(quantity: 5, unit_price: 900, status: 2, item_id: item_4.id, invoice_id: invoice_7.id)
      invoice_item_9 = InvoiceItem.create!(quantity: 5, unit_price: 900, status: 2, item_id: item_4.id, invoice_id: invoice_14.id)
      invoice_item_9 = InvoiceItem.create!(quantity: 5, unit_price: 900, status: 2, item_id: item_4.id, invoice_id: invoice_15.id)

      invoice_item_10 = InvoiceItem.create!(quantity: 5, unit_price: 900, status: 2, item_id: item_5.id, invoice_id: invoice_8.id)
      invoice_item_10 = InvoiceItem.create!(quantity: 5, unit_price: 900, status: 2, item_id: item_5.id, invoice_id: invoice_16.id)
      invoice_item_10 = InvoiceItem.create!(quantity: 5, unit_price: 900, status: 2, item_id: item_5.id, invoice_id: invoice_17.id)

      invoice_item_11 = InvoiceItem.create!(quantity: 5, unit_price: 900, status: 2, item_id: item_6.id, invoice_id: invoice_9.id)
      invoice_item_11 = InvoiceItem.create!(quantity: 5, unit_price: 900, status: 2, item_id: item_6.id, invoice_id: invoice_18.id)
      invoice_item_11 = InvoiceItem.create!(quantity: 5, unit_price: 900, status: 2, item_id: item_6.id, invoice_id: invoice_19.id)

      expect(item_1.top_day).to eq("7/30/22")
      expect(item_2.top_day).to eq("7/29/22")
      expect(item_3.top_day).to eq("7/30/22")
      expect(item_4.top_day).to eq("7/29/22")
      expect(item_5.top_day).to eq("7/30/22")
      expect(item_6.top_day).to eq("7/29/22")
    end
  end
end

# Merchant Items Index: Top Item's Best Day

# When I visit the items index page
# Then next to each of the 5 most popular items I see the date with the most sales for each item.
# And I see a label “Top selling date for <item name> was <date with most sales>"

# Note: use the invoice date. If there are multiple days with equal number of sales, return the most recent day.