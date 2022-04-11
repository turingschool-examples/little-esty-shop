require 'rails_helper'

RSpec.describe Item, type: :model do
  describe 'relationships' do

    it { should belong_to :merchant }
  end

  describe 'instance methods' do
    describe '.unit_price_to_currency' do
      it 'can convert a unit price of total cents to a currency format' do
        merchant = Merchant.create!(name: "Jim's Rare Guitars")
        item_1 = merchant.items.create!(name: "1959 Gibson Les Paul",
                            description: "Tobacco Burst Finish, Rosewood Fingerboard",
                            unit_price: 25000000)
        item_2 = merchant.items.create!(name: "1959 Gibson Les Paul",
                            description: "Tobacco Burst Finish, Rosewood Fingerboard",
                            unit_price: 25000039)
        expect(item_1.unit_price_to_currency).to eq("250000.00")
        expect(item_2.unit_price_to_currency).to eq("250000.39")
      end
    end
  end
end
