require 'rails_helper'

RSpec.describe Item, type: :model do

  describe 'relationships' do
    it { should belong_to(:merchant)}
    it { should have_many(:invoice_items)}
    it { should have_many(:invoices).through(:invoice_items)}
  end

  describe 'validations' do
    it { should validate_presence_of(:name) }
    it { should validate_presence_of(:description) }
    it { should validate_presence_of(:unit_price) }
    it { should validate_numericality_of(:unit_price) }
  end
  
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
