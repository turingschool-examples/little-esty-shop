require 'rails_helper'

RSpec.describe Merchant, type: :model do
  describe "Relationships" do
    it { should have_many(:items) }
  end

  describe "instance methods" do 
    describe "#enabled_items" do 
      it "returns a collection of the enabled items for the merchant instance" do 
        merchant = Merchant.create!(name: "Practical Magic Shop")
        book = merchant.items.create!(name: "Book of the dead", description: "book of necromamcy spells", unit_price: 4)
        candle = merchant.items.create!(name: "Candle of life", description: "candle that gifts everlasting life", unit_price: 15)
        potion = merchant.items.create!(name: "Love potion", description: "One serving size of true love potion", unit_price: 10, status: 1)

        expect(merchant.enabled_items).to eq([book, candle])

        coffee = merchant.items.create!(name: "Coffee mug", description: "Its a mug", unit_price: 1, status: 0)

        expect(merchant.enabled_items).to eq([book, candle, coffee])
      end
    end

    describe "#disabled_items" do 
      it "returns a collection of the disabled items for the merchant instance" do 
        merchant = Merchant.create!(name: "Practical Magic Shop")
        book = merchant.items.create!(name: "Book of the dead", description: "book of necromamcy spells", unit_price: 4)
        candle = merchant.items.create!(name: "Candle of life", description: "candle that gifts everlasting life", unit_price: 15)
        potion = merchant.items.create!(name: "Love potion", description: "One serving size of true love potion", unit_price: 10, status: 1)

        expect(merchant.disabled_items).to eq([potion])

        coffee = merchant.items.create!(name: "Coffee mug", description: "Its a mug", unit_price: 1, status: 1)

        expect(merchant.disabled_items).to eq([potion, coffee])
      end
    end
  end
end