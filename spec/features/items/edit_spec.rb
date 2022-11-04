require 'rails_helper'

RSpec.feature "Merchant Items Edit Page", type: :feature do
  before :each do
    @merchant = Merchant.create!(name: 'Gemma Belle')
    @item = @merchant.items.create!(name: "Wooden Necklace", description: "A necklace with wood beads.", unit_price: 1000)
  end
  describe 'when accessing the page' do
    it 'has a link in the merchant item show page that redirects to the edit page for that item' do
      visit merchant_item_path(@merchant, @item)
      click_link 'Update item'

      expect(page).to have_current_path(edit_merchant_item_path(@merchant, @item))
    end
  end
  describe 'when visiting the page' do
    it 'has form fields prefilled with the existing item attributes' do
      visit edit_merchant_item_path(@merchant, @item)

      expect(page).to have_field('Name:', with: 'Wooden Necklace')
      expect(page).to have_field('Description:', with: 'A necklace with wood beads.')
      expect(page).to have_field('Price:', with: 1000)
    end
    it 'redirects to the item show page with the updated information when the form is filled and submitted' do
      visit edit_merchant_item_path(@merchant, @item)

      fill_field 'Name:', with: 'Starry Woods'
      fill_field 'Description:', with: 'A necklace with a carved wooden pendant.'
      click_button 'Update'

      expect(page).to have_current_path(merchant_item_path(@merchant, @item))
      expect(page).not_to have_content('Wooden Necklace')
      expect(page).not_to have_content('A necklace with wood beads.')
      expect(page).to have_content('Starry Woods')
      expect(page).to have_content('A necklace with a carved wooden pendant.')
      expect(page).to have_content('Current price: 1000')
    end
    it 'displays a flash message stating the update is successful when the item is successfully updated' do
      visit edit_merchant_item_path(@merchant, @item)

      fill_field 'Name:', with: 'Starry Woods'
      fill_field 'Description:', with: 'A necklace with a carved wooden pendant.'
      click_button 'Update'

      expect(page).to have_current_path(merchant_item_path(@merchant, @item))
      expect(page).to have_content('Item updated successfully!')
    end
  end
end
