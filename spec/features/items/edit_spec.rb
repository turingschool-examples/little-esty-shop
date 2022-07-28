require 'rails_helper'

 RSpec.describe 'Item Edit' do
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

  describe 'I see a form filled in with the existing item attribute information' do
    it 'when I update the information in the form and click submit i am redirected back to the item show page where i see the update information and see a flash message stating that the information has been succesfully updated' do
      
      visit "/merchants/#{@merchant1.id}/items/#{@item1.id}"

      click_link 'Update Item Information'

      expect(current_path).to eq("/merchants/#{@merchant1.id}/items/#{@item1.id}/edit")
      expect(page).to have_field('Name', with: "T-shirts")
      expect(page).to have_field('Description', with: "Blue")
      expect(page).to have_field('Price', with: "$12.00")

      fill_in "Name", with: " "
      fill_in "Description", with: " "
      fill_in "Price", with: "letters"

      click_button 'Submit'

      expect(current_path).to eq("/merchants/#{@merchant1.id}/items/#{@item1.id}/edit")
      expect(page).to have_content("Error: Name can't be blank, Description can't be blank, Unit price is not a number")
     

      fill_in "Name", with: "Polo button down"
      fill_in "Description", with: "Green"
      fill_in "Price", with: "154"

      click_button 'Submit'

      expect(current_path).to eq("/merchants/#{@merchant1.id}/items/#{@item1.id}")
      expect(page).to have_content("Polo button down")
      expect(page).to have_content("Green")
      expect(page).to have_content("$154.00")
    end
  end
end