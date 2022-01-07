require 'rails_helper'
describe Invoice, type: :model do
  describe 'relationships' do
    it { should have_many :invoice_items }
    it { should have_many(:items).through(:invoice_items) }
    it { should belong_to :customer }
    it { should have_many :transactions }
  end

  describe 'enum' do
    it { should define_enum_for(:status).with_values([:cancelled, 'in progress', :completed])}
  end

  describe 'instance and class methods' do
    it '#total_revenue' do
      merchant_1 = Merchant.create!(name: 'merchant_1')
      customer_1 = Customer.create!(first_name: 'customer_1', last_name: 'last_name_1')
      invoice_1 = Invoice.create!(customer_id: customer_1.id, status: 1)
      item_1 = Item.create!(name: 'item_1', description: 'item_1_description', unit_price: 1, merchant_id: merchant_1.id)
      item_2 = Item.create!(name: 'item_2', description: 'item_2_description', unit_price: 2, merchant_id: merchant_1.id)
      invoice_item_1 = InvoiceItem.create!(item_id: item_1.id, invoice_id: invoice_1.id, quantity: 1, unit_price: 2, status: 1)
      invoice_item_2 = InvoiceItem.create!(item_id: item_2.id, invoice_id: invoice_1.id, quantity: 2, unit_price: 3, status: 2)

      expect(invoice_1.total_revenue).to eq(5)
    end
  end

  # describe 'methods' do
  #   xit '' do
  #     invoice_1 = Invoice.create!(customer_id: customer_1.id, status: 0)
  #     invoice_1 = Invoice.create!(customer_id: customer_1.id, status: 0)
  #     invoice_1 = Invoice.create!(customer_id: customer_1.id, status: 0)
  #     invoice_1 = Invoice.create!(customer_id: customer_1.id, status: 0)
  #
  #   end
  end
