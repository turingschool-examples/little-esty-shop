require 'rails_helper'

RSpec.describe InvoiceItem, type: :model do
  describe 'relationships' do
    it { should belong_to :invoice }
    it { should belong_to :item }
  end

  describe 'methods' do
    it 'item name' do
      merchant = Merchant.create!(name: "Stephen's Shady Store")
      item = merchant.items.create!(name: "Item Toothpaste", description: "The worst toothpaste you can find", unit_price: 4000 )
      customer = Customer.create!(first_name: 'Jeff', last_name: 'Bridges')
      invoice = customer.invoices.create!(status: 'in progress')
      invoice_item = invoice.invoice_items.create!(item_id: item.id, 
                                         quantity: 1,
                                         unit_price: 6000,
                                         status: :pending)

      expect(invoice_item.item_name).to eq(item.name)
    end
  end
end
