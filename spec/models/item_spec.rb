require 'rails_helper'

RSpec.describe Item, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"

  describe 'class methods' do
    it '#invoice_finder' do
      merchant1 = create(:merchant)
      invoice1 = create(:invoice)
      item1 = create(:item, merchant: merchant1)
      invoice_item1 = create(:invoice_item, item_id: item1.id, invoice_id: invoice1.id)
      expect(Item.invoice_finder(item1.merchant_id)).to eq [invoice1]
    end
  end
end
