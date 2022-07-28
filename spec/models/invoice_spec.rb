require 'rails_helper'

RSpec.describe Invoice do

  describe 'enums' do
    it 'does' do
      expect { define_enum_for(:status).with_values(['in progress', 'cancelled', 'completed']) }
    end
  end

  describe 'relationships' do
    it { should have_many (:invoice_items) }
    it { should have_many (:transactions) }
    it { should have_many(:items).through(:invoice_items) }
    it { should have_many(:merchants).through(:items)}
  end

  describe 'validations' do
    it { should validate_presence_of :status }
  end

  describe 'instance methods' do
    it "can sum the invoices total revenue" do
      merchant1 = Merchant.create!(name: "Poke Retirement homes")
      merchant2 = Merchant.create!(name: "Rendolyn Guizs poke stops")
      merchant3 = Merchant.create!(name: "Dhirley Secasrio's knits and bits")

      item1 = Item.create!(name: "Pikachu pics", description: 'Cute pics with pikachu', unit_price: 1000, merchant_id: merchant1.id)
      item2 = Item.create!(name: "Pokemon stuffy", description: 'Pikachu stuffed toy', unit_price: 2000, merchant_id: merchant1.id)
      item3 = Item.create!(name: "Junk", description: 'junk you should want', unit_price: 500, merchant_id: merchant3.id)

      customer1 = Customer.create!(first_name: "Parker", last_name: "Thomson")
      invoice1 = Invoice.create!(status: "completed", customer_id: customer1.id)
      invoice2 = Invoice.create!(status: "cancelled", customer_id: customer1.id)
      invoice3 = Invoice.create!(status: "in progress", customer_id: customer1.id)
      transaction1 = Transaction.create!(credit_card_number: "123456789123456789", result: "success", invoice_id: invoice1.id)
      invoice_item1 = InvoiceItem.create!(quantity: 1, unit_price: item1.unit_price, status: "shipped", item_id: item1.id, invoice_id: invoice1.id)
      invoice_item2 = InvoiceItem.create!(quantity: 2, unit_price: item2.unit_price, status: "pending", item_id: item2.id, invoice_id: invoice1.id)
      invoice_item3 = InvoiceItem.create!(quantity: 3, unit_price: item3.unit_price, status: "packaged", item_id: item3.id, invoice_id: invoice3.id)

      expect(invoice1.total_revenue(merchant1)).to eq(5000)
      expect(invoice2.total_revenue(merchant2)).to eq(0)
      expect(invoice3.total_revenue(merchant3)).to eq(1500)
    end
  end
end
