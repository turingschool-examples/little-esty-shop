require 'rails_helper'

RSpec.describe Item, type: :model do
  describe 'validations' do
    it { should validate_presence_of :name }
    it { should validate_presence_of :description }
    it { should validate_presence_of :unit_price }
    it { should validate_presence_of :merchant_id }
  end

  describe 'relationships' do
    it { should belong_to :merchant }
    it { should have_many :invoice_items }
    it { should have_many(:invoices).through(:invoice_items) }
  end

  describe "instance methods" do
    describe "#current_price" do
      it 'should divide the unit_price by 100' do
        merch1 = Merchant.create!(name: Faker::Movies::VForVendetta.character)

        item1 = Item.create!(name: Faker::Games::Minecraft.item, description: Faker::Games::Minecraft.block, unit_price: 1550, merchant_id: merch1.id)

        expect(item1.current_price).to eq 15.50
      end
    end
  end
end