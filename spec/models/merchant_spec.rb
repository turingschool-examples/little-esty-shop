require 'rails_helper'

RSpec.describe Merchant, type: :model do
  describe "relationships" do
    it { should have_many :items }
  end

  describe "validations" do
    it { should validate_presence_of(:name) }
  end

  describe 'instance variables' do
    it 'filters items by status' do
      merchant_1 = FactoryBot.create(:merchant)
      item_1 = FactoryBot.create(:item, status: 0, merchant: merchant_1)
      item_2 = FactoryBot.create(:item, status: 1, merchant: merchant_1)
      item_3 = FactoryBot.create(:item, status: 0, merchant: merchant_1)
      item_4 = FactoryBot.create(:item, status: 1, merchant: merchant_1)

      expect(merchant_1.filter_item_status(0)).to include(item_1, item_1)
      expect(merchant_1.filter_item_status(1)).to include(item_2, item_4)
    end
  end
end
