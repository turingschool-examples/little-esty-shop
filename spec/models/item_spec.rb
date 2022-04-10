require 'rails_helper'

RSpec.describe Merchant, type: :model do
  describe 'instance methods' do
    describe '.unit_price_to_currency' do
      it 'can convert a unit price of total cents to a currency format' do
        item = Item.create!(name: "1959 Gibson Les Paul",
                            description: "Tobacco Burst Finish, Rosewood Fingerboard",
                            unit_price: 25000000)
        expect(item.unit_price_to_currency).to eq(250000.00)
      end
    end
  end
end
