require 'rails_helper'

RSpec.describe 'merchant items show page' do 
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

    describe "When I click on the name of an item from the merchant items index page" do
      describe "Then I am taken to that merchant's item's show page (/merchants/merchant_id/items/item_id)" do 
        
        it "show page is specific to a item in the url" do
          visit ("/merchants/#{@dk.id}/items/#{@funnypowder.id}")
          
          expect(page).to_not have_content("#{@whb.name}")
          expect(page).to_not have_content("#{@klein_rempel.name}")
          expect(page).to_not have_content("#{@ufo.name}")
          expect(page).to_not have_content("#{@watch.name}")
          expect(page).to_not have_content("#{@bike.description}")
        end

        it "displays all of the item's attributes including: Name, Description, Current Selling Price" do
          visit ("/merchants/#{@dk.id}/items/#{@funnypowder.id}")
          
          expect(page).to have_content("#{@dk.name}")
          
          within("#merchant-items-#{@funnypowder.id}") do
            expect(page).to have_content("#{@funnypowder.name}")
            expect(page).to have_content("#{@funnypowder.description}")
            expect(page).to have_content("#{@funnypowder.unit_price}")
            expect(page).to_not have_content("#{@dk.name}")
          # save_and_open_page
          # require 'pry';binding.pry
          end
        end
      end
    end
end