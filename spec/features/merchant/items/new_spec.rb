require 'rails_helper'

RSpec.describe 'Merchant New Item Page', type: :feature do
  before(:each) do
    @merchant_1 = create(:merchant)

    visit new_merchant_item_path(@merchant_1.id)
  end

  describe 'Merchant Item Create (User Story 11)' do
    it 'has a header' do
      expect(page).to have_content("New Item")
    end

    it 'has form fields to create the item' do
      expect(find('form')).to have_field('Name')
      expect(find('form')).to have_field('Description')
      expect(find('form')).to have_field('Unit price')
    end

    it 'has a submit button for the form' do
      expect(page).to have_button('Create Item')
    end

    context 'submit valid data' do
      before(:each) do
        fill_in 'Name', with: 'New Item Name'
        fill_in 'Description', with: 'New Item Description'
        fill_in 'Unit price', with: 1000
        click_button 'Create Item'
      end

      it 'creates the item and redirects to the merchent item index page' do
        expect(current_path).to eq(merchant_items_path(@merchant_1.id))
        expect(page).to have_content('New Item Name')
      end

      it 'displays a flash message for a successful item update' do
        expect(page).to have_content('Item successfully saved!')
      end
    end

    context 'submit invalid data' do
      before(:each) do
        fill_in 'Description', with: 'New Item Description'
        fill_in 'Unit price', with: 1000
        click_button 'Create Item'
      end

      it 'does not update the item and re-renders the new item form' do
        expect(page).to have_content("New Item")
      end

      it 'displays a flash message for an unsuccessful item update' do
        expect(page).to have_content('Error: Name can\'t be blank')
      end
    end
  end
end
