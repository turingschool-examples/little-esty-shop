require 'rails_helper'

RSpec.describe Item do
  describe 'relationships' do
    it {should have_many :invoice_items}
    it {should belong_to :merchant}
  end

  describe 'instance methods' do
    describe '#price' do
      it 'returns the unit price formatted as a float in dollars' do
        merchant = Merchant.create(name: 'Toys and Stuff')
        item = merchant.items.create(
          name: 'fidget spinner',
          description: 'it spins',
          unit_price: 1500
        )

        expect(item.price).to be_a Float
        expect(item.price).to eq 15.00
      end
    end
  end
end
