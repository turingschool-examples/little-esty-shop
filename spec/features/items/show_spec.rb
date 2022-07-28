require 'rails_helper'

RSpec.describe 'Merchant Items Show' do
  before :each do
    @merchant1 = Merchant.create!(name: "Calvin Klein")
    @merchant2 = Merchant.create!(name: "Marc Jacobs")
    @merchant3 = Merchant.create!(name: "Yves Saint Laurent")

    @item1 = Item.create!(name: "T-shirts", description: "Blue" , unit_price: 12 , merchant_id: @merchant1.id)
    @item2 = Item.create!(name: "Shorts", description: "Green", unit_price: 45, merchant_id: @merchant2.id)
    @item3 = Item.create!(name: "Chinos", description: "White", unit_price: 67, merchant_id: @merchant1.id)
    @item4 = Item.create!(name: "Hat", description: "Multicolor", unit_price: 84, merchant_id: @merchant2.id)
    @item5 = Item.create!(name:"Socks", description: "Grey", unit_price: 9, merchant_id: @merchant3.id)
    @item6 = Item.create!(name: "Sneakers", description: "Bone", unit_price: 122 , merchant_id: @merchant3.id)
  end

  describe 'As a merchant' do
    describe 'when i visit the merchant show page of an item' do
      it 'I see a link to update the item information. When I click the link then i am taken to a page to edit this item' do
        
        visit "/merchants/#{@merchant1.id}/items/#{@item1.id}"

        click_link 'Update Item Information'

        expect(current_path).to eq("/merchants/#{@merchant1.id}/items/#{@item1.id}/edit")
      end
    end
  end
end