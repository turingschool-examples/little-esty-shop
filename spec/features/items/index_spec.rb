require 'rails_helper'

RSpec.describe 'Merchant Items Index' do
  before :each do
    @merchant1 = Merchant.create!(name: "Calvin Klein")
    @merchant2 = Merchant.create!(name: "Marc Jacobs")
    @merchant3 = Merchant.create!(name: "Yves Saint Laurent")

    @item1 = Item.create!(name: "T-shirts", description: "Blue" , unit_price: 12 , merchant_id: @merchant1.id, status: 1)
    @item2 = Item.create!(name: "Shorts", description: "Green", unit_price: 45, merchant_id: @merchant2.id)
    @item3 = Item.create!(name: "Chinos", description: "White", unit_price: 67, merchant_id: @merchant1.id)
    @item4 = Item.create!(name: "Hat", description: "Multicolor", unit_price: 84, merchant_id: @merchant2.id)
    @item5 = Item.create!(name:"Socks", description: "Grey", unit_price: 9, merchant_id: @merchant3.id)
    @item6 = Item.create!(name: "Sneakers", description: "Bone", unit_price: 122 , merchant_id: @merchant3.id)
  end

  describe 'As a merchant' do
    describe 'When i visit my merchant items index page' do
      it 'I see a list of the names of all of my items and i do not see items for any other merchant' do
        
        visit "/merchants/#{@merchant1.id}/items"

        within "#item-#{@item1.id}" do
          expect(page).to have_content(@item1.name)
        end

        within "#item-#{@item3.id}" do
          expect(page).to have_content(@item3.name)
        end
        
        expect(page).to_not have_content(@item2.name)
        expect(page).to_not have_content(@item4.name)
        expect(page).to_not have_content(@item5.name)
        expect(page).to_not have_content(@item6.name)
      end

      it 'i see a button next to each item name that will disable or enable that item. When I click this button then i am redirected back to the items index and i see that the items status has changed' do
        
        visit "/merchants/#{@merchant1.id}/items"

        within "#item-#{@item1.id}" do
          expect(page).to have_button("Enable Item")
        end
       
        within "#item-#{@item3.id}" do
          expect(page).to have_button("Disable Item")
        end

        within "#item-#{@item1.id}" do
          click_button "Enable Item"
        end

        expect(current_path).to eq("/merchants/#{@merchant1.id}/items")
        expect(page).to have_content("T-shirts has been enabled.")

        within "#item-#{@item3.id}" do
          click_button "Disable Item"
        end

        expect(current_path).to eq("/merchants/#{@merchant1.id}/items")
        expect(page).to have_content("Chinos has been disabled.")
       
      end
    end
    describe 'when i click on the name of an item from the merchant items index page' do
      it 'I am taken to that merchant items show page and i see all of the items attributes' do

        visit "/merchants/#{@merchant1.id}/items"

        expect(page).to have_link("T-shirts")
        expect(page).to have_link("Chinos")

        click_link 'T-shirts'

        expect(current_path).to eq("/merchants/#{@merchant1.id}/items/#{@item1.id}")

        expect(page).to have_content(@item1.name)
        expect(page).to have_content(@item1.description)
        expect(page).to have_content(@item1.unit_price)
        expect(page).to_not have_content(@item2.name)
        expect(page).to_not have_content(@item3.name)
        expect(page).to_not have_content(@item4.name)
        expect(page).to_not have_content(@item5.name)
        expect(page).to_not have_content(@item6.name)
      end
    end
  end
end