require 'rails_helper'

describe 'As a merchant' do
  describe "When I visit a merchant's item's edit page (/merchants/merchant_id/items/item_id/edit)" do
    before :each do 
      @max = Merchant.create!(name: 'Merch Max')
    end 
    
    it 'I see a form filled in with the existing item attribute information' do
      visit "merchants/#{@max.id}/items/new"
  
      expect(page).to have_selector("input[id='item_name']")
      expect(page).to have_selector("input[id='item_description']")
      expect(page).to have_selector("input[id='item_unit_price']")
    end

    describe "When I fill out the form and hit 'Submit'" do
      before :each do 
        visit "merchants/#{@max.id}/items/new"

        fill_in 'Name:', with: 'Legumes'
        fill_in 'Description:', with: 'A new and improved description'
        fill_in 'Unit Price:', with: '10'

        click_button 'Submit'
      end

      it 'Then I am taken back to the items index page' do
        expect(current_path).to eq(merchant_items_path(@max.id))
      end

      it "Then I see the item I just created displayed in the list of items" do 
        expect(page).to have_content('Legumes')
      end

      it "Then I see my item was created with a default status of disabled" do 
        expect(page).to have_content("Status: Disabled")
      end
    end
  end
end
