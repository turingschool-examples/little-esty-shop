require 'rails_helper'

RSpec.describe Item, type: :model do
  describe 'relationships' do
    it { should belong_to(:merchant) }
    it { should have_many(:invoice_items) }
    it { should have_many(:invoices).through(:invoice_items) }
  end

  describe 'instance methods' do
    before :each do
      @merchant = Merchant.create!(name: 'Gemma Belle')
      @item = @merchant.items.create!(name: "Wooden Necklace", description: "A necklace with wood beads.", unit_price: 1000)
    end
    describe '.price_in_dollars' do
      it 'should convert price cent values into equivalent dollar values' do
        expect(@item.price_in_dollars).to eq(10)
        expect(@item.price_in_dollars).to be_a(Float)
      end
    end
  end
end