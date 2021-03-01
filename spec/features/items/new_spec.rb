require 'rails_helper'

RSpec.describe "New Item Page" do
  before(:each) do
    @merchant = create(:merchant)
  end
  describe "As a merchant" do
    describe "from the items index page" do
      it "has a link to create a new item" do
        visit merchant_items_path(@merchant)
        
        expect(page).to have_link("Create Item")
      end
      
      describe "when I click on the link" do
        it "takes me to a form that allows me to add item information"do
        visit merchant_items_path(@merchant)

        click_link("Create Item")
        expect(current_path).to eq(new_merchant_item_path(@merchant))
        end
      end
      

      describe "When I fill out the form I click ‘Submit’" do
        it "Takes me back to the items index page" do
          visit new_merchant_item_path(@merchant)
          
          expect(page).to have_field('item[name]')
          expect(page).to have_field('item[description]')
          expect(page).to have_field('item[unit_price]')
          expect(page).to have_button("Create Item")
          
          fill_in 'item[name]', with: "A new Item"
          fill_in 'item[description]', with: "A fancy new Item"
          fill_in 'item[unit_price]', with: 5
          
          click_button("Create Item")
          expect(current_path).to eq(merchant_items_path(@merchant))
          expect(page).to have_content("Your item has been successfully created")
        end
        
        it "displays an error message if the information is not correct" do
          visit new_merchant_item_path(@merchant)
          
          fill_in 'item[name]', with: "A new Item"
          fill_in 'item[description]', with: ""
          fill_in 'item[unit_price]', with: 5
          
          click_button("Create Item")

          expect(current_path).to eq(new_merchant_item_path(@merchant))
          expect(page).to have_content("ERROR: Missing required information")
        end
        
        it "Shows the item I just created displayed in the list of items with a default status of disabled" do
          visit new_merchant_item_path(@merchant)

          fill_in 'item[name]', with: "A new Item"
          fill_in 'item[description]', with: "A fancy new Item"
          fill_in 'item[unit_price]', with: 5
          
          click_button("Create Item")

          within("#merchant-items-list") do
            expect(page).to have_content('disabled')
            expect(page).to have_button('Enable')
          end
          save_and_open_page
        end
      end
    end
  end
end
