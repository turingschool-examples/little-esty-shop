require 'rails_helper'

RSpec.describe Item, type: :model do

  describe 'validations' do
    it { should validate_presence_of :name }
    it { should validate_presence_of :description }
    it { should validate_numericality_of :unit_price}
  end

  describe 'relationships' do
    it { should belong_to :merchant }
    it { should have_many :invoice_items }
    it { should have_many(:invoices).through(:invoice_items) }
  end

  describe "class methods " do
    it "should filter by enabled and disabled buttons" do
      mer_1 = create(:merchant)
      item_1 = create(:item, merchant_id: mer_1.id, item_status: true)
      item_2 = create(:item, merchant_id: mer_1.id, item_status: false)
      item_3 = create(:item, merchant_id: mer_1.id, item_status: true)

      item_4 = create(:item, merchant_id: mer_1.id,item_status: false)
      item_5 = create(:item, merchant_id: mer_1.id, item_status: true)
      item_6 = create(:item, merchant_id: mer_1.id, item_status: false)
      expect(Item.enabled_items).to eq([item_1, item_3, item_5])
      expect(Item.disabled_items).to eq([item_2, item_4, item_6])
    end
  end
end
