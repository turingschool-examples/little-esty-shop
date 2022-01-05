require 'rails_helper'

RSpec.describe Item, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"

  describe 'class methods' do
    let!(:merchant){Merchant.create!(name: "Bill's Flowers")}
    let!(:item1){merchant.items.create!(name: "rose", description: "red", unit_price: 5)}
    invoice1 = FactoryBot.create(:invoice)
    let!(:invoice_item1){InvoiceItem.create!(item_id: item1.id, invoice_id: invoice1.id, quantity: 12, unit_price: 5, status: 0)}
    it '#invoice_finder' do
      expect(Item.invoice_finder(merchant.id)).to eq [invoice1]
    end
  end
end
