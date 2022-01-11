require 'rails_helper'
describe InvoiceItem, type: :model do
  describe 'relationships' do
    it { should belong_to :invoice }
    it { should belong_to :item }
  end

  describe 'enum' do
    it { should define_enum_for(:status).with_values({packaged: 0, pending: 1, shipped: 2})}
  end

  describe 'instance and class methods' do
    it '#item_name' do
      customer_1 = create(:customer)
      merchant_6 = Merchant.create!(name: 'Rob')
      item_6 = create(:item, merchant_id: merchant_6.id, unit_price: 5, name: 'item_6_name')
      invoice_6 = Invoice.create!(customer_id: customer_1.id, status: 2, created_at: "2012-03-25 09:54:09 UTC")
      invoice_item_6 = create(:invoice_item, item_id: item_6.id, invoice_id: invoice_6.id, status: 1, quantity: 1, unit_price: 5)

      expect(invoice_item_6.item_name).to eq(item_6.name)
    end
  end
end
