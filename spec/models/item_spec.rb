require 'rails_helper'
describe Item, type: :model do
  describe 'relationships' do
    it { should belong_to :merchant }
    it { should have_many :invoice_items}
    it { should have_many(:invoices).through(:invoice_items) }
  end

  describe 'instance and class methods' do
    it '#disabled_items' do
      @merchant1 = Merchant.create!(name: 'Hair Care')

      @item1 = Item.create!(name: "Shampoo", description: "This washes your hair", unit_price: 10, merchant_id: @merchant1.id)
      @item2 = Item.create!(name: "Conditioner", description: "This makes your hair shiny", unit_price: 8, merchant_id: @merchant1.id)
      @item3 = Item.create!(name: "Brush", description: "This takes out tangles", unit_price: 5, merchant_id: @merchant1.id)
      @item4 = Item.create!(name: "Shampoo Bar", description: "Eco friendly shampoo", unit_price: 7, merchant_id: @merchant1.id, status: 1)

      expect(@merchant1.disabled_items).to eq([@item1, @item2, @item3])
    end

    it '#enabled_items' do
      @merchant1 = Merchant.create!(name: 'Hair Care')

      @item1 = Item.create!(name: "Shampoo", description: "This washes your hair", unit_price: 10, merchant_id: @merchant1.id)
      @item2 = Item.create!(name: "Conditioner", description: "This makes your hair shiny", unit_price: 8, merchant_id: @merchant1.id)
      @item3 = Item.create!(name: "Brush", description: "This takes out tangles", unit_price: 5, merchant_id: @merchant1.id)
      @item4 = Item.create!(name: "Shampoo Bar", description: "Eco friendly shampoo", unit_price: 7, merchant_id: @merchant1.id, status: 1)

      expect(@merchant1.enabled_items).to eq([@item4])
    end
  end


  # add validations so that form can't be
  # incomplete. All attributes validated.

end
