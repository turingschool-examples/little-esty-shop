require 'rails_helper'

RSpec.describe Item do
  describe 'associations' do
    it { should have_many :invoice_items}
    it { should have_many(:invoices).through(:invoice_items)}
  end

  describe 'validations' do
    it { should validate_presence_of :name}
    it { should validate_presence_of :description}
    it { should validate_presence_of :unit_price}
  end

  describe '#convert_to_dollars' do
    it 'can convert cents to dollars' do
      merch_1 = Merchant.create!(name: "Two-Legs Fashion")
      item_1 = merch_1.items.create!(name: "Two-Leg Pantaloons", description: "pants built for people with two legs", unit_price: 5086)
      item_2 = merch_1.items.create!(name: "Two-Leg Shorts", description: "shorts built for people with two legs", unit_price: 2999)
      item_3 = merch_1.items.create!(name: "Hat", description: "hat built for people with two legs and one head", unit_price: 6000)

      expect(item_1.unit_price_to_dollars).to eq(50.86)
      expect(item_2.unit_price_to_dollars).to eq(29.99)
      expect(item_3.unit_price_to_dollars).to eq(60.00)
    end
  end

  describe '#merchant_object' do
    it 'can access merchant object through item' do
      merch_1 = Merchant.create!(name: "Two-Legs Fashion")
      merch_2 = Merchant.create!(name: "Two-Legs Fashion")
      item_1 = merch_1.items.create!(name: "Two-Leg Pantaloons", description: "pants built for people with two legs", unit_price: 5086)
      item_2 = merch_1.items.create!(name: "Two-Leg Shorts", description: "shorts built for people with two legs", unit_price: 2999)
      item_3 = merch_2.items.create!(name: "Hat", description: "hat built for people with two legs and one head", unit_price: 6000)

      expect(item_1.merchant_object).to eq(merch_1)
      expect(item_2.merchant_object).to eq(merch_1)
      expect(item_3.merchant_object).to eq(merch_2)
    end
  end
end