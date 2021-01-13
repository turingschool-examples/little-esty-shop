require 'rails_helper'

RSpec.describe Merchant, type: :model do
  describe "relationships" do
    it { should have_many :invoices }
    it { should have_many :customers }
    it { should have_many :items }
  end

  describe 'instance methods' do
    before :each do
      @merchant1 = Merchant.create!(name: "Robert Heath")

      @item1 = Item.create!(name: "magic pen", description: "special", unit_price: 9.10, enabled: true, merchant_id: @merchant1.id)
      @item2 = Item.create!(name: "preposterous pencil", description: "big", unit_price: 8.50, enabled: true, merchant_id: @merchant1.id)
      @item3 = Item.create!(name: "fantastic fountain pen", description: "small", unit_price: 55.00, merchant_id: @merchant1.id)
    end

    it 'can find all enabled items for a merchant' do
      expect(@merchant1.enabled_items).to eq([@item1, @item2])
    end

    it 'can find all disabled items for a merchant' do
      expect(@merchant1.disabled_items).to eq([@item3])
    end
  end
end
