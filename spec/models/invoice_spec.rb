require 'rails_helper'

RSpec.describe Invoice, type: :model do
  describe 'relationships' do
    it { should belong_to(:customer) }
    it { should have_many(:invoice_items) }
    it { should have_many(:items).through(:invoice_items) }
    it { should have_many(:transactions) }
  end

  describe 'instance methods' do
    describe '#invoice_item(item_id)' do 
      before :each do
        @crystal_moon = Merchant.create!(name: "Crystal Moon Designs")
        @surf_designs = Merchant.create!(name: "Surf & Co. Designs")
        @emerald = @crystal_moon.items.create!(name: "Emerald", description: "Where's Sonic?", unit_price: 85)
        @surf_board = @surf_designs.items.create!(name: "Surf Board", description: "Our original 12' board!", unit_price: 200)
        @snorkel = @surf_designs.items.create!(name: "Snorkel", description: "Perfect for reef viewing!", unit_price: 400)
        @abbas = Customer.create!(first_name: "Abbas", last_name: "Firnas")
        @invoice_6 = Invoice.create!(status: 2, customer_id: @abbas.id)
        @emerald_invoice = InvoiceItem.create!(item_id: @emerald.id, invoice_id: @invoice_6.id, quantity: 2, unit_price: 85, status: 2)
        @surf_board_invoice = InvoiceItem.create!(item_id: @surf_board.id, invoice_id: @invoice_6.id, quantity: 2, unit_price: 200, status: 1)
        @snorkel_invoice = InvoiceItem.create!(item_id: @snorkel.id, invoice_id: @invoice_6.id, quantity: 3, unit_price: 400, status: 1)
      end
      it 'gives us access to each invoice item' do
        expect(@invoice_6.invoice_item(@emerald.id)).to eq(@emerald_invoice)
        expect(@invoice_6.invoice_item(@surf_board.id)).to eq(@surf_board_invoice)
      end
    end

    describe '#total_revenue(merchant_id)' do
      it 'gives us the total revenue of all items on this invoice that belong to the given merchant' do
        expect(@invoice_6.total_revenue(@surf_designs.id)).to eq(1600)
      end
    end
  end
end
