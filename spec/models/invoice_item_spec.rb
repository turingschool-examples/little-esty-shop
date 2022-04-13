require 'rails_helper'

RSpec.describe InvoiceItem, type: :model do
  describe 'validations' do
    it { should validate_presence_of(:quantity) }
    it { should validate_presence_of(:status) }
    it { should validate_presence_of(:created_at) }
    it { should validate_presence_of(:updated_at) }
  end

  describe 'relationships' do
    it { should belong_to(:item) }
    it { should belong_to(:invoice) }
  end

  describe 'instance methods' do

    it 'returns an invoice_items unit_price to dollars / formatted' do
      merch1 = FactoryBot.create(:merchant)
      cust1 = FactoryBot.create(:customer)
      item1 = Item.create!(name: 'Eldens Ring', description: 'its a ring', unit_price: 75107, merchant_id: merch1.id, created_at: Time.now, updated_at: Time.now)

      invoice1 = FactoryBot.create(:invoice, customer_id: cust1.id)
      invoice_item_1 = FactoryBot.create(:invoice_item, unit_price: item1.unit_price, item_id: item1.id, invoice_id: invoice1.id)
      expect(invoice_item_1.price_to_dollars).to eq(751.07)

    end



  end
end
