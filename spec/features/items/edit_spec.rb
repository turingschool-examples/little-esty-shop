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
      
        visit ("/merchants/#{@dk.id}/items/#{@funnypowder.id}/edit")
        expect(page).to_not have_field('Item Name', with:"#{@ufo.name}")
        expect(page).to_not have_field('Item Description', with:"#{@bike.description}")
        expect(page).to_not have_field('Item Unit Price', with:"#{@watch.unit_price}")

        expect(page).to have_field('Item Name', with:"#{@funnypowder.name}")
        expect(page).to have_field('Item Description', with:"#{@funnypowder.description}")
        expect(page).to have_field('Item Unit Price', with:"#{@funnypowder.unit_price}")

        expect("#{@funnypowder.name}").to appear_before("#{@funnypowder.unit_price}")
        expect("#{@funnypowder.unit_price}").to_not appear_before("#{@funnypowder.description}")
      end

      it "redirects back to the item show page when user clicks 'Submit item:id Update'" do
        visit ("/merchants/#{@dk.id}/items/#{@funnypowder.id}/edit")
        expect(page).to_not have_content("#{@dk.name}")
        
        click_button "Submit #{@funnypowder.name} Update"

        expect(current_path).to eq("/merchants/#{@dk.id}/items/#{@funnypowder.id}")
        expect(page).to have_content("#{@dk.name}")
      end

      it "user can update info in the form which is reflected in the item show page after user hits 'submit'" do
        visit ("/merchants/#{@dk.id}/items/#{@funnypowder.id}/edit")

        fill_in('Item Description', with:"Prank your friends, prank your mom, BUT dont prank cops")
        
        click_button "Submit #{@funnypowder.name} Update"
        
        expect(current_path).to eq("/merchants/#{@dk.id}/items/#{@funnypowder.id}")
        
        expect(page).to have_content("Prank your friends, prank your mom, BUT dont prank cops")
        expect(page).to_not have_content("#{@funnypowder.description}")
      end
      
      it "displays a flash message stating that the info has been successfully updated" do
        visit ("/merchants/#{@dk.id}/items/#{@funnypowder.id}/edit")
        
        fill_in('Item Description', with:"Prank your friends, prank your mom, BUT dont prank cops")
        
        click_button "Submit #{@funnypowder.name} Update"
 
        expect(page).to have_content("The Information Has Successfully Updated")
      end
    end
  end
end