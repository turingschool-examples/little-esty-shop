require 'rails_helper'

RSpec.describe 'new merchant item', type: :feature do
  describe 'as a merchant' do 
    describe 'when I visit /merchants/:id/items/new' do
      before :each do
        @crystal_moon = Merchant.create!(name: "Crystal Moon Designs")
        @surf_designs = Merchant.create!(name: "Surf & Co. Designs")
        @sun_glasses = @surf_designs.items.create!(name: "Polarized Sport Sun Glasses", description: "Don't let the sun blind your surf!", unit_price: 75)
        @wax = @surf_designs.items.create!(name: "Board Wax", description: "Hang ten!", unit_price: 7)
        @rash_guard = @surf_designs.items.create!(name: "Radical Rash Guard", description: "Stay totally groovy and rash free!", unit_price: 50)
        @zinc = @surf_designs.items.create!(name: "100% Zinc Face Protectant", description: "Our original organic formula!", unit_price: 13)
      end 

      it '- shows a form that allows me to add new item information.' do
        visit "/merchants/#{@surf_designs.id}/items/new"

        expect(page).to have_selector(:css, "form")
        expect(page).to have_field(:name)
        expect(page).to have_field(:description)
        expect(page).to have_field(:price)
      end

      it '- when I fill out the form, I click (submit). then I am directed back to the items index page, where I see
      the new item displayed in the list of items with a default status of disabled.' do
        visit "/merchants/#{@surf_designs.id}/items/new"

        fill_in 'Name', with: 'Polarized Sport Sun Glasses'
        fill_in 'Description', with: "Don't let the sun blind your surf!"
        fill_in 'Price', with: 75
        click_on 'Submit'

        expect(current_path).to eq("/merchants/#{@surf_designs.id}/items") # post

        within "#disabled" do
          expect(page).to have_content("Polarized Sport Sun Glasses")
        end
      end
    end
  end
end