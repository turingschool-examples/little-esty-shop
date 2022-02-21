require 'rails_helper'

RSpec.describe Item, type: :model do
  describe 'relationships' do
    it {should have_many(:invoice_items)}
    it {should have_many(:invoices).through(:invoice_items)}

  end

  describe 'display price method' do
    it 'will display dollars in cents' do
      merchant_1 = Merchant.create!(name: "Ana Maria")
      merchant_2 = Merchant.create!(name: "Juan Lopez")
      item_1 = merchant_1.items.create!(name: "cheese", description: "european cheese", unit_price: 2475)
      item_2 = merchant_2.items.create!(name: "onion", description: "red onion", unit_price: 3450)

      expect(item_2.display_price).to eq("34.50")
      expect(item_1.display_price).to eq("24.75")
    end
  end

  describe 'class methods' do
    describe '#get_name_from_invoice' do
      it "lists items names that are on invoices" do
        @katz = Merchant.create!(name: 'Katz Kreations')
        @mrpickles = Customer.create!(first_name: 'Mr', last_name: 'Pickles')
        @sashimi = Customer.create!(first_name: 'Sashimi', last_name: 'Kity')
        @invoice1 = Invoice.create!(status: 0, customer_id: @mrpickles.id)
        @invoice2 = Invoice.create!(status: 0, customer_id: @mrpickles.id)
        @item1 = Item.create!(name: 'food', description: 'delicious', unit_price: '2000', merchant_id: @katz.id)
        @item2 = Item.create!(name: 'toy', description: 'fun', unit_price: '5000', merchant_id: @katz.id)
        @invoice_item1 = InvoiceItem.create!(item_id: @item1.id, invoice_id: @invoice1.id, quantity: 2, unit_price: 100, status: 1)
        @invoice_item2 = InvoiceItem.create!(item_id: @item2.id, invoice_id: @invoice1.id, quantity: 2, unit_price: 100, status: 2)

        expect(Item.name).to eq([])
      end
    end
  end
end
