require 'rails_helper'

RSpec.describe Item do
  describe 'validations' do
    it {should validate_presence_of :name}
    it {should validate_presence_of :description}
    it {should validate_presence_of :unit_price}
    it {should validate_presence_of :merchant_id}
  end

  describe 'relationships' do
    it {should belong_to :merchant}
  end

  it 'can return a list of items enabled for a merchant' do
    merchant_1 = Merchant.create!(name: "Cool Shirts")
    item_1 = Item.create!(name: "New shirt", description: "ugly shirt", unit_price: 1400, merchant_id: merchant_1.id, status: 'enabled')
    item_2 = Item.create!(name: "Old shirt", description: "moderately ugly shirt", unit_price: 1200, merchant_id: merchant_1.id, status: 'enabled')

    expect(merchant_1.items_enabled_list).to eq([item_1, item_2])
  end
end
