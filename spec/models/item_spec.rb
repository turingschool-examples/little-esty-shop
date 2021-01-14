require 'rails_helper'

RSpec.describe Item, type: :model do
  describe "relationships" do
    it { should have_many :invoice_items }
    it { should have_many :invoices }
    it { should belong_to :merchant }
  end

  describe 'validations' do
    it { should validate_presence_of :name }
    it { should validate_presence_of :description }
    it { should validate_presence_of :unit_price }
    it { should validate_numericality_of(:unit_price).is_greater_than(0) }
  end

  describe 'class methods' do
    before :each do
      @merchant1 = Merchant.create!(name: "Robert Heath")

      @item1 = Item.create!(name: "magic pen", description: "special", unit_price: 9.10, enabled: true, merchant_id: @merchant1.id)
      @item2 = Item.create!(name: "preposterous pencil", description: "big", unit_price: 8.50, enabled: true, merchant_id: @merchant1.id)
      @item3 = Item.create!(name: "fantastic fountain pen", description: "small", unit_price: 55.00, merchant_id: @merchant1.id)
    end

    it 'can find all items that are enabled' do
      expect(Item.all_enabled_items).to eq([@item1, @item2])
    end

    it 'can find all items that are disabled' do
      expect(Item.all_disabled_items).to eq([@item3])
    end

    it 'can find the top 5 items by revenue' do
      expect(Item.top_5_items).to eq([@item1, @item2, @item3, @item4, @item5])
    end
  end
end