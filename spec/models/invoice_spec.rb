require 'rails_helper'

RSpec.describe Invoice, type: :model do
  describe 'relationships' do
    it { should belong_to :customer }
    it { should have_many :invoice_items }
    it { should have_many :transactions }
    it { should have_many(:items).through(:invoice_items) }
    # it { should have_one(:merchant).through(:items) }
  end

  describe 'validations' do
    it { should validate_presence_of :status }
    it { should validate_presence_of :customer_id }
  end
  describe 'total_revenue' do
    it 'totals revenue from all invoice items' do
      customer_1 = Customer.create!(first_name: 'Eli', last_name: 'Fuchsman')
      merchant = Merchant.create!(name: 'Test')
      item_1 = Item.create!(name: 'item1', description: 'desc1', unit_price: 10, merchant_id: merchant.id)
      item_2 = Item.create!(name: 'item2', description: 'desc1', unit_price: 10, merchant_id: merchant.id)
      invoice_1 = Invoice.create!(customer_id: customer_1.id, status: 1)
      ii_1 = InvoiceItem.create!(invoice_id: invoice_1.id, item_id: item_1.id, quantity: 9, unit_price: 10,
        status: 1)
      ii_1 = InvoiceItem.create!(invoice_id: invoice_1.id, item_id: item_2.id, quantity: 9, unit_price: 10,
        status: 1)
      transaction_1 = Transaction.create!(credit_card_number: '1', result: 0, invoice_id: invoice_1.id)
      transaction_2 = Transaction.create!(credit_card_number: '1', result: 0, invoice_id: invoice_1.id)
      expect(invoice_1.total_revenue).to eq(180)
  
    end
  end
end