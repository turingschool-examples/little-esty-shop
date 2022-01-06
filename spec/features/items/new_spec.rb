require 'rails_helper'

RSpec.describe 'Items New Page' do
  describe 'view' do
    it 'displays to the user that they are on the Create a New Item Page' do
      visit "/merchants/#{@merchant_1.id}/items/new"

      expect(page).to have_content("Create a New Item")
    end

    it 'fills out and submits form' do
      visit "/merchants/#{@merchant_1.id}/items/new"

      fill_in('Name', with: 'Beef Jerkey')
      fill_in('Description', with: '1lb of Smoked Jerkey')
      fill_in('Unit Price', with: 750)
      click_button('Submit')

      new_item_name = Item.last.name
      expect(current_path).to eq("/merchants/#{@merchant_1.id}/items")
      expect(page).to have_content("#{new_item_name}")
    end

    # it 'fills out form with status defaulted as disabled' do
    #   visit "/merchants/#{@merchant_1.id}/items/new"
    #
    #   fill_in('Name', with: 'Beef Jerkey')
    #   fill_in('Description', with: '1lb of Smoked Jerkey')
    #   fill_in('Unit Price', with: 750)
    #   click_button('Submit')
    #
    #   new_item_name = Item.last.name
    #   expect(current_path).to eq("/merchants/#{@merchant_1.id}/items")
    #   expect(page).to have_content("#{new_item_name}")
    # end
  end
end
