# require 'rails_helper'
#
# RSpec.describe 'the merchant item page' do
#   it 'item name is a link to that items page' do
#     merchant1 = Merchant.first
#     merchant2 = Merchant.second
#
#     m1i1 = Merchant.first.items.first
#     m2i1 = Merchant.second.items.first
#     m2i2 = Merchant.second.items.second
#     m2i3 = Merchant.second.items.third
#
#     visit "/merchants/#{merchant1.id}/items"
#
#     expect(page).to have_link('Item Qui Esse')
#     expect(page).to_not have_link('Item Adipisci Sint')
#     expect(page).to_not have_link('Item Laudantium Ex')
#     expect(page).to_not have_link('Item Reiciendis Est')
#
#     click_link('Item Qui Esse')
#
#     expect(current_path).to eq("/merchants/#{merchant1.id}/items/#{m1i1.id}")
#     expect(page).to have_content("Description: #{m1i1.description}")
#     expect(page).to have_content('Price: $751.07')
#     expect(page).to_not have_content("Description: #{m2i1.description}")
#     expect(page).to_not have_content('Price: $229.51')
#
#     # visit merchant_path(merchant2)
#     visit "/merchants/#{merchant2.id}/items"
#
#     expect(current_path).to eq("/merchants/#{merchant2.id}/items")
#     expect(page).to have_content('Klein, Rempel and Jones')
#     expect(page).to have_link('Item Adipisci Sint')
#     expect(page).to have_link('Item Laudantium Ex')
#     expect(page).to have_link('Item Reiciendis Est')
#     expect(page).to_not have_link('Item Qui Esse')
#
#     click_link('Item Adipisci Sint')
#
#     expect(current_path).to eq("/merchants/#{merchant2.id}/items/#{m2i1.id}")
#     expect(page).to have_content("Description: #{m2i1.description}")
#     expect(page).to have_content('Price: $229.51')
#     expect(page).to_not have_content("Description: #{m1i1.description}")
#     expect(page).to_not have_content('Price: $751.07')
#     expect(page).to_not have_content("Description: #{m2i2.description}")
#     expect(page).to_not have_content('Price: $607.13')
#
#     # visit merchant_path(merchant2)
#     visit "/merchants/#{merchant2.id}/items"
#     click_link('Item Laudantium Ex')
#
#     expect(current_path).to eq("/merchants/#{merchant2.id}/items/#{m2i2.id}")
#     expect(page).to have_content("Description: #{m2i2.description}")
#     expect(page).to have_content('Price: $607.13')
#
#     # visit merchant_path(merchant2)
#     visit "/merchants/#{merchant2.id}/items"
#
#     click_link('Item Reiciendis Est')
#
#     expect(current_path).to eq("/merchants/#{merchant2.id}/items/#{m2i3.id}")
#     expect(page).to have_content("Description: #{m2i3.description}")
#     expect(page).to have_content('Price: $364.60')
#   end
#
#   it 'has a link to update the information' do
#     merchant1 = Merchant.first
#     merchant2 = Merchant.second
#     merchant3 = Merchant.third
#
#     m1i1 = Merchant.first.items.first
#     m2i1 = Merchant.second.items.first
#     m2i2 = Merchant.second.items.second
#     m2i3 = Merchant.second.items.third
#
#     visit "/merchants/#{merchant1.id}/items/#{m1i1.id}"
#     # visit merchant_items_path(merchant1, m1i1)
#
#     expect(page).to have_button("Update #{m1i1.name}")
#     click_button("Update #{m1i1.name}")
#
#     expect(current_path).to eq("/merchants/#{merchant1.id}/items/#{m1i1.id}/edit")
#   end
# end
# As a merchant,
# When I visit the merchant show page of an item
# I see a link to update the item information.
# When I click the link
# Then I am taken to a page to edit this item
# And I see a form filled in with the existing item attribute information
# When I update the information in the form and I click ‘submit’
# Then I am redirected back to the item show page where I see the updated information
# And I see a flash message stating that the information has been successfully updated.
