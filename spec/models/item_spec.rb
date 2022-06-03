require 'rails_helper'

RSpec.describe Item, type: :model do
  describe "relationships" do
    it { should belong_to :merchant }
    it { should have_many :invoice_items }
    it { should have_many(:invoices).through(:invoice_items) }
  end

  describe 'validations' do
    it {should validate_presence_of :name}
    it {should validate_presence_of :description}
    it {should validate_numericality_of :unit_price}
    it {should define_enum_for(:status).with_values(["Disabled", "Enabled"])}
  end

  describe 'class methods' do 
    it 'returns enabled items' do 
      merchant = create(:merchant)
      item = create(:item, merchant: merchant, status: 1)
      item2 = create(:item, merchant: merchant, status: 0)
      item3 = create(:item, merchant: merchant, status: 1)

      expect(Item.enabled_items).to eq([item, item3])
      expect(Item.enabled_items).to_not eq([item2])
    end

    it 'returns disabled items' do 
      merchant = create(:merchant)
      item = create(:item, merchant: merchant, status: 1)
      item2 = create(:item, merchant: merchant, status: 0)
      item3 = create(:item, merchant: merchant, status: 1)

      expect(Item.disabled_items).to eq([item2])
      expect(Item.disabled_items).to_not eq([item, item3])
    end 
  end
end
