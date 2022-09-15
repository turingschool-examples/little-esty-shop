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
  end
end
