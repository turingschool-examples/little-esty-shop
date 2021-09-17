require 'rails_helper'

RSpec.describe 'Merchant Item Edit page' do
  context 'when I visit a merchant item edit page' do
    before(:each) do
      @item = create(:item)

      visit "/merchants/#{@item.merchant.id}/items/#{@item.id}/edit"
    end

    it 'has a form with current info' do
      expect(page).to have_field('item[name]',        with: 'cookies')
      expect(page).to have_field('item[description]', with: 'whoopdie-doo!')
      expect(page).to have_field('item[unit_price]',  with: 12345 )
    end

    it 'updates info and redirects to show page' do
      fill_in('item[name]',        with: 'choco-chip cookies')
      fill_in('item[description]', with: 'chocolatey delicious!')
      fill_in('item[unit_price]',  with: 54321 )
      click_button('Submit')

      expect(current_path).to eq("/merchants/#{@item.merchant.id}/items/#{@item.id}")
      expect(page).to have_content('choco-chip cookies')
      expect(page).to have_content('Description: chocolatey delicious!')
      expect(page).to have_content('Current Selling Price: 54321')
    end

    it 'shows a flash message when we get to the show page' do
      fill_in('item[name]',        with: 'choco-chip cookies')
      fill_in('item[description]', with: 'chocolatey delicious!')
      fill_in('item[unit_price]',  with: 54321 )
      click_button('Submit')

      within '#flash-message' do
        expect(page).to have_content('choco-chip cookies has been successfully updated!')
      end
    end
  end
end


# And I see a flash message stating that the information has been successfully updated.
