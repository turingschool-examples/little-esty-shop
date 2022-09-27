require 'rails_helper'

RSpec.describe Invoice, type: :model do
  describe 'relationships' do
    it { should belong_to :customer }
    it { should have_many :transactions }
    it { should have_many :invoice_items }
    it { should have_many(:items).through(:invoice_items) }
  end

  describe 'methods' do
    it 'customer_name' do
      customer = Customer.create!(first_name: 'Jeff', last_name: 'Bridges')
      invoice = customer.invoices.create!(status: 'in progress')
      expect(invoice.customer_name).to eq("#{customer.first_name} #{customer.last_name}")
    end

    it 'total_revenue' do
      customer = Customer.create!(first_name: 'Jeff', last_name: 'Bridges')
      invoice = customer.invoices.create!(status: 'in progress')
      merchant = Merchant.create!(name: "Stephen's Shady Store")
      item_toothpaste = merchant.items.create!(name: "Item Toothpaste", description: "The worst toothpaste you can find", unit_price: 4000 )
      item_rock = merchant.items.create!(name: "Item Rock", description: "Decently cool rock", unit_price: 10000 )
      invoice.invoice_items.create!(item_id: item_toothpaste.id,
                                    quantity: 1,
                                    unit_price: 6000,
                                    status: :pending)
      invoice.invoice_items.create!(item_id: item_rock.id,
                                    quantity: 3,
                                    unit_price: 12000,
                                    status: :shipped)
      expect(invoice.total_revenue).to eq(42000)
    end

    it 'can find discounted revenue' do
      merchant1 = Merchant.create!(name: "Robespierre", status: 'Enabled')
      customer1 = Customer.create(first_name: 'Jack', last_name: 'Black')
      discount1 = BulkDiscount.create(merchant_id: merchant1.id, threshold: 15, discount: 10)
      invoice1 = Invoice.create(status: "completed", customer_id: customer1.id)
      item1 = Item.create(name: 'Fountian Pen', description: 'The fanciest of pens', unit_price: 10, merchant_id: merchant1.id)
      invoice_item1 = InvoiceItem.create(invoice_id: invoice1.id, item_id: item1.id, quantity: 20, unit_price: 1000, status: 'shipped')

      expect(invoice1.discounted_revenue).to eq(18000)
    end

    it '#incomplete' do
      @invoice1 = create(:invoice, status: "in progress")
      create_list(:invoiceItem, 5, invoice_id: @invoice1.id, status: :shipped)
      @invoice2 = create(:invoice, created_at: Date.new(2019,7,18))
      create_list(:invoiceItem, 3, invoice_id: @invoice2.id, status: :pending)
      create_list(:invoiceItem, 3, invoice_id: @invoice2.id, status: :shipped)
      @invoice3 = create(:invoice, created_at: Date.new(2019,7,17))
      create_list(:invoiceItem, 5, invoice_id: @invoice3.id, status: :packaged)

      expect(Invoice.incomplete).to eq([@invoice3, @invoice2])
    end
  end
  
end
