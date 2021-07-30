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
  end
end
