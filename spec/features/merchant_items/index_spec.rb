require 'rails_helper'

RSpec.describe 'the mechant items index' do
  describe 'display' do
    it 'visit' do
      visit merchant_items_path(@merchant1)
    end

    it 'displays merchant name and items' do
      visit merchant_items_path(@merchant1)

      expect(page).to have_content('Costco')
      expect(page).to have_content('Milk')
      expect(page).to have_content('Potato Chips')
      expect(page).to have_content('Hot Dog')
      expect(page).to have_content('Steaks')
      expect(page).to_not have_content('Frying Pan')
    end
  end
end
