require 'rails_helper'

RSpec.describe 'item creation' do
  before(:each) do
    @merchant_1 = create(:merchant)

    @item_1 = create(:item, merchant: @merchant_1)
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
          visit "/merchants/#{@merchant.id}/items/new"

          fill_in 'Name', with: "Bort's Bumblebeet Lip Balm"
          fill_in 'Description', with: "All natural ingredient pure beet balm from the bearded Bort you can trust"
          fill_in 'Unit Price', with: 15
          click_button 'Save'
          expect(page).to have_current_path("/merchants/#{@merchant.id}/items")
          expect(page).to have_content("Bort's Bumblebeet Lip Balm")
          expect(page).to have_content("All natural ingredient pure beet balm from the bearded Bort you can trust")
        end
      end
    end

    describe 'given invalid data' do
      it 're-renders the new form' do
        visit "/merchants/#{@merchant.id}/items/new"

        click_button 'Submit'
        expect(page).to have_current_path("/merchants/#{@merchant.id}/items/new")
        expect(page).to have_content("Error: Name can't be blank, Description can't be blank, Unit Price can't be blank and must be a number")
      end
    end
  end
end
