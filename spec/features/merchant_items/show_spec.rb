require 'rails_helper'

RSpec.describe 'the merchant items show' do
  describe 'display' do
    it 'visit' do
      visit merchant_item_path(@merchant1, @item1)
    end

    it 'displays item name and its attributes' do
      visit merchant_item_path(@merchant1, @item1)

      expect(page).to have_content('Milk')
      expect(page).to have_content('A large quantity of whole milk')
      expect(page).to have_content('500')
    end

    it 'has an update link' do
      visit merchant_item_path(@merchant1, @item1)

      expect(page).to have_link("Update #{@item1.name}")
    end

    it 'can click update link and be taken to update page' do
      visit merchant_item_path(@merchant1, @item1)

      click_link("Update #{@item1.name}")

      expect(current_path).to eq(edit_merchant_item_path(@merchant1, @item1))
    end
  end
end
