require 'rails_helper'

RSpec.describe 'Merchant Item Edit Page', type: :feature do
  before(:each) do
    @merchant_1 = create(:merchant)
    @item_1 = create(:item, merchant: @merchant_1)

    visit edit_merchant_item_path(@merchant_1.id, @item_1)
  end

  describe 'Merchant Item Update (User Story 8)' do
    it 'has a header' do
      expect(page).to have_content("Edit Item")
    end

    it 'has form fields to edit the item' do
      expect(find('form')).to have_field('Name')
      expect(find('form')).to have_field('Description')
      expect(find('form')).to have_field('Unit price')
    end

    it 'has pre-filled values in the form' do
      expect(find_field('Name').value).to eq(@item_1.name.to_s)
      expect(find_field('Description').value).to eq(@item_1.description.to_s)
      expect(find_field('Unit price').value).to eq(@item_1.unit_price.to_s)
    end

    it 'has a submit button for the form' do
      expect(page).to have_button('Update Item')
    end

    context 'submit valid data' do
      it 'updates the item and redirects to the item show page' do
        fill_in 'Name', with: 'New Item Name'
        click_button 'Update Item'

        expect(current_path).to eq(merchant_item_path(@merchant_1.id, @item_1))
        expect(page).to have_content('New Item Name')
      end

      it 'displays a flash message for a successful item update' do
        fill_in 'Name', with: 'New Item Name'
        click_button 'Update Item'

        expect(page).to have_content('Item successfully updated!')
      end
    end

    context 'submit invalid data' do
      it 'does not update the item and re-renders the edit form' do
        fill_in 'Name', with: ''
        click_button 'Update Item'

        expect(current_path).to eq(merchant_item_path(@merchant_1.id, @item_1))
      end

      it 'displays a flash message for an unsuccessful item update' do
        fill_in 'Name', with: ''
        click_button 'Update Item'

        expect(page).to have_content('Error: Name can\'t be blank')
      end
    end
  end
end
