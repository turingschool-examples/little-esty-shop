require 'rails_helper'

RSpec.describe 'item creation' do
  before(:each) do
    Merchant.destroy_all
    Item.destroy_all
    @merchant_1 = create(:merchant)
  end

  describe 'the new item page' do
    it 'renders the new form' do
      visit "/merchants/#{@merchant_1.id}/items/new"

      expect(page).to have_content('New Item')
      expect(find('form')).to have_content('Name')
      expect(find('form')).to have_content('Description')
      expect(find('form')).to have_content('Unit Price')
    end
  end

  describe 'create item' do
    describe 'given valid data' do
      describe "It creates the item and redirects to the merchant's item index." do
        it "displays the item just created in the list of items with a default status of disabled." do
          visit "/merchants/#{@merchant_1.id}/items/new"

          fill_in 'Name', with: "Bort's Bumblebeet Lip Balm"
          fill_in 'Description', with: "All natural ingredient pure beet balm from the bearded Bort you can trust"
          fill_in 'Unit Price', with: 15
          click_button 'Submit'
          expect(page).to have_current_path("/merchants/#{@merchant_1.id}/items")
          expect(page).to have_content("Bort's Bumblebeet Lip Balm")
        end
      end
    end

    describe 'given invalid data' do
      it 're-renders the new form' do
        visit "/merchants/#{@merchant_1.id}/items/new"

        click_button 'Submit'
        expect(page).to have_current_path("/merchants/#{@merchant_1.id}/items/new")
        expect(page).to have_content("Error: Invalid Input. Complete all forms.")
      end
    end
  end
end
