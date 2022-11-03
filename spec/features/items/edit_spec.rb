require 'rails_helper'

RSpec.describe 'Merchant Item Update' do 
  before :each do 
    @klein_rempel = Merchant.create!(name: "Klein, Rempel and Jones")
    @whb = Merchant.create!(name: "WHB")
    @dk = Merchant.create!(name: "Dickinson-Klein")
    
    @watch = @klein_rempel.items.create!(name: "Watch", description: "Tells time on your wrist", unit_price: 300)
    @radio = @klein_rempel.items.create!(name: "Radio", description: "Broadcasts radio stations", unit_price: 150)
    @speaker = @klein_rempel.items.create!(name: "Speakers", description: "Listen to your music LOUD", unit_price: 250)

    @ufo = @dk.items.create!(name: "UFO Board", description: "Out of this world MotherBoard", unit_price: 400)
    @funnypowder = @dk.items.create!(name: "Funny Brick of Powder", description: "White Powder with Gasoline Smell", unit_price: 5000)
    @binocular = @dk.items.create!(name: "Binoculars", description: "See everything from afar", unit_price: 300)
    @tent = @dk.items.create!(name: "Tent", description: "Spend the night under the stars... or under THEM!", unit_price: 500)

    @bike = @whb.items.create!(name: "Bike", description: "Two wheel Huffy bike", unit_price: 99)
    @trex = @whb.items.create!(name: "T-Rex", description: "Skull of a Dinosaur", unit_price: 100000)
  end

  describe "the merchant's item's show page (/merchants/merchant_id/items/item_id) has a 'Update/item' button" do
    describe "when the button is clicked, the user is taken to a page to edit this item" do
      it "has a form filled in with the existing item attribute information" do

        visit ("/merchants/#{@dk.id}/items/#{@funnypowder.id}")
        
        click_button "Update Item"
        expect(current_path).to eq("/merchants/#{@dk.id}/items/#{@funnypowder.id}/edit")
        
        expect(page).to have_content("#{@funnypowder.name} Edit Page")
        expect(page).to have_content("Item Name")
        expect(page).to have_content("Item Description")
        expect(page).to have_content("Item Unit Price")
      end
      
      # ** need to test user input ** 
      # fill_in "Item Name", with:("#{@funnypowder.name}")
      # fill_in "Item Description", with:("#{@funnypowder.description}")
      # expect(page).to have_content("#{@funnypowder.name}")
      # expect(page).to have_content("#{@funnypowder.description}")
      # expect(page).to have_content("#{@funnypowder.unit_price}")

      it "redirects back to the item show page when user clicks 'Submit item:id Update' where I see the updated information" do
        visit ("/merchants/#{@dk.id}/items/#{@funnypowder.id}/edit")

        click_button "Submit #{@funnypowder.name} Update"
        expect(current_path).to eq("/merchants/#{@dk.id}/items/#{@funnypowder.id}")
      end
    end
  end
end