require 'rails_helper'

RSpec.describe Invoice, type: :model do
  describe 'relationships' do
    it { should belong_to :customer }
    it { should have_many :transactions }
    it { should have_many :invoice_items }
    it { should have_many(:items).through(:invoice_items) }
    it { should have_many(:merchants).through(:items) }
  end

  describe 'validations' do
    it { should validate_presence_of :customer_id }
    it { should validate_presence_of :status }
  end 

  describe 'methods' do
    it 'can return total invoice revenue' do
    merchant_1 = Merchant.create!(name: 'Hair Care')


    item_1 = Item.create!(name: "Shampoo", description: "This washes your hair", unit_price: 10, merchant_id: merchant_1.id)
    item_2 = Item.create!(name: "Bracelet", description: "Wrist bling", unit_price: 200, merchant_id: merchant_1.id)

    customer_1 = Customer.create!(first_name: 'Joey', last_name: 'Smith')
    customer_2 = Customer.create!(first_name: 'Joy', last_name: 'Smith')

    invoice_1 = Invoice.create!(customer_id: customer_1.id, status: 1)

    ii_1 = InvoiceItem.create!(invoice_id: invoice_1.id, item_id: item_1.id, quantity: 9, unit_price: 10, status: 0, created_at: "2012-03-27 14:54:09")
    ii_2 = InvoiceItem.create!(invoice_id: invoice_1.id, item_id: item_2.id, quantity: 1, unit_price: 10, status: 0, created_at: "2012-03-27 14:54:09")

    expect(invoice_1.total_revenue).to eq(100)
    end
  end
end
