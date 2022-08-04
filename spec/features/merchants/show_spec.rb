require 'rails_helper'

RSpec.describe 'the merchant show page' do
  it 'shows the merchants page and all of their items' do
    merchant1 = Merchant.create!(name: 'Fake Merchant', status: 'Enabled')
    merchant2 = Merchant.create!(name: 'Another Merchant', status: 'Disabled')
    merchant3 = Merchant.create!(name: 'Faux Merchant', status: 'Enabled')

    item1 = Item.create!(name: 'Crap', description: 'Because you buy stuff for no reason', unit_price: 9999, merchant_id: merchant1.id)
    item2 = Item.create!(name: 'Junk', description: 'You have room', unit_price: 10999, merchant_id: merchant1.id)
    item3 = Item.create!(name: 'BS', description: 'Filling the void in your life', unit_price: 11999, merchant_id: merchant1.id)
    merch2item = Item.create!(name: 'Impracticality', description: 'Underselling the other guy', unit_price: 11998, merchant_id: merchant2.id)

    visit "/merchants/#{merchant1.id}/items"

    expect(page).to have_content('Fake Merchant')
    expect(page).to have_content('Name: Crap')
    expect(page).to have_content('Description: Because you buy stuff for no reason')
    expect(page).to have_content('Price: $99.99')
    expect(page).to have_content('Name: Junk')
    expect(page).to have_content('Description: You have room')
    expect(page).to have_content('Price: $109.99')
    expect(page).to have_content('Name: BS')
    expect(page).to have_content('Description: Filling the void in your life')
    expect(page).to have_content('Price: $119.99')
    expect(page).to_not have_content('Another Merchant')
    expect(page).to_not have_content('Name: Impracticality')
    expect(page).to_not have_content('Faux Merchant')

    visit "/merchants/#{merchant2.id}/items"

    expect(page).to have_content('Another Merchant')
    expect(page).to have_content('Name: Impracticality')
    expect(page).to have_content('Description: Underselling the other guy')
    expect(page).to have_content('Price: $119.98')
    expect(page).to_not have_content('Fake Merchant')
    expect(page).to_not have_content('Faux Merchant')

    visit "/merchants/#{merchant3.id}/items"

    expect(page).to have_content('Faux Merchant')
    expect(page).to_not have_content('Fake Merchant')
    expect(page).to_not have_content('Another Merchant')
  end

  describe 'the merchant item index page' do
    it 'item name is a link to that items page' do
      merchant1 = Merchant.create!(name: 'Fake Merchant', status: 'Enabled')
      merchant2 = Merchant.create!(name: 'Another Merchant', status: 'Disabled')
      merchant3 = Merchant.create!(name: 'Faux Merchant', status: 'Enabled')

      item1 = Item.create!(name: 'Crap', description: 'Because you buy stuff for no reason', unit_price: 9999, merchant_id: merchant1.id)
      item2 = Item.create!(name: 'Junk', description: 'You have room', unit_price: 10999, merchant_id: merchant1.id)
      item3 = Item.create!(name: 'BS', description: 'Filling the void in your life', unit_price: 11999, merchant_id: merchant1.id)
      merch2item = Item.create!(name: 'Impracticality', description: 'Underselling the other guy', unit_price: 11998, merchant_id: merchant2.id)

      visit "/merchants/#{merchant1.id}/items"

      expect(page).to have_content('Fake Merchant')
      expect(page).to have_link('Crap')
      expect(page).to have_content('Description: Because you buy stuff for no reason')
      expect(page).to have_content('Price: $99.99')
      expect(page).to have_link('Junk')
      expect(page).to have_content('Description: You have room')
      expect(page).to have_content('Price: $109.99')
      expect(page).to have_link('BS')
      expect(page).to have_content('Description: Filling the void in your life')
      expect(page).to have_content('Price: $119.99')
      expect(page).to_not have_link('Another Merchant')
      expect(page).to_not have_link('Name: Impracticality')
      expect(page).to_not have_link('Faux Merchant')

      click_link('Crap')

      expect(current_path).to eq("/merchants/#{merchant1.id}/items/#{item1.id}")
      expect(page).to have_content('Crap')
      expect(page).to have_content('Description: Because you buy stuff for no reason')
      expect(page).to have_content('Price: $99.99')
      expect(page).to_not have_content('Description: You have room')
      expect(page).to_not have_content('Price: $109.99')
      expect(page).to_not have_content('Description: Underselling the other guy')
      expect(page).to_not have_content('Price: $119.98')

      visit "/merchants/#{merchant2.id}/items"

      expect(page).to have_content('Another Merchant')
      expect(page).to have_link('Impracticality')
      expect(page).to have_content('Description: Underselling the other guy')
      expect(page).to have_content('Price: $119.98')
      expect(page).to_not have_content('Fake Merchant')
      expect(page).to_not have_content('Faux Merchant')

      click_link('Impracticality')

      expect(current_path).to eq("/merchants/#{merchant2.id}/items/#{merch2item.id}")
      expect(page).to have_content('Impracticality')
      expect(page).to have_content('Description: Underselling the other guy')
      expect(page).to have_content('Price: $119.98')

      # merchant1 = Merchant.first
      # merchant2 = Merchant.second
      #
      # m1i1 = Merchant.first.items.first
      # m2i1 = Merchant.second.items.first
      # m2i2 = Merchant.second.items.second
      # m2i3 = Merchant.second.items.third
      #
      # visit "/merchants/#{merchant1.id}/items"
      #
      # expect(page).to have_link('Item Qui Esse')
      # expect(page).to_not have_link('Item Adipisci Sint')
      # expect(page).to_not have_link('Item Laudantium Ex')
      # expect(page).to_not have_link('Item Reiciendis Est')
      #
      # click_link('Item Qui Esse')
      #
      # expect(current_path).to eq("/merchants/#{merchant1.id}/items/#{m1i1.id}")
      # expect(page).to have_content("Description: #{m1i1.description}")
      # expect(page).to have_content('Price: $751.07')
      # expect(page).to_not have_content("Description: #{m2i1.description}")
      # expect(page).to_not have_content('Price: $229.51')
      #
      # # visit merchant_path(merchant2)
      # visit "/merchants/#{merchant2.id}/items"
      #
      # expect(current_path).to eq("/merchants/#{merchant2.id}/items")
      # expect(page).to have_content('Klein, Rempel and Jones')
      # expect(page).to have_link('Item Adipisci Sint')
      # expect(page).to have_link('Item Laudantium Ex')
      # expect(page).to have_link('Item Reiciendis Est')
      # expect(page).to_not have_link('Item Qui Esse')
      #
      # click_link('Item Adipisci Sint')
      #
      # expect(current_path).to eq("/merchants/#{merchant2.id}/items/#{m2i1.id}")
      # expect(page).to have_content("Description: #{m2i1.description}")
      # expect(page).to have_content('Price: $229.51')
      # expect(page).to_not have_content("Description: #{m1i1.description}")
      # expect(page).to_not have_content('Price: $751.07')
      # expect(page).to_not have_content("Description: #{m2i2.description}")
      # expect(page).to_not have_content('Price: $607.13')
      #
      # # visit merchant_path(merchant2)
      # visit "/merchants/#{merchant2.id}/items"
      # click_link('Item Laudantium Ex')
      #
      # expect(current_path).to eq("/merchants/#{merchant2.id}/items/#{m2i2.id}")
      # expect(page).to have_content("Description: #{m2i2.description}")
      # expect(page).to have_content('Price: $607.13')
      #
      # # visit merchant_path(merchant2)
      # visit "/merchants/#{merchant2.id}/items"
      #
      # click_link('Item Reiciendis Est')
      #
      # expect(current_path).to eq("/merchants/#{merchant2.id}/items/#{m2i3.id}")
      # expect(page).to have_content("Description: #{m2i3.description}")
      # expect(page).to have_content('Price: $364.60')
    end

    it 'has a link to update the information' do
      merchant1 = Merchant.create!(name: 'Fake Merchant', status: 'Enabled')
      merchant2 = Merchant.create!(name: 'Another Merchant', status: 'Enabled')
      merchant3 = Merchant.create!(name: 'Faux Merchant', status: 'Enabled')

      item1 = Item.create!(name: 'Crap', description: 'Because you buy stuff for no reason', unit_price: 9999, merchant_id: merchant1.id)
      item2 = Item.create!(name: 'Junk', description: 'You have room', unit_price: 10999, merchant_id: merchant1.id)
      item3 = Item.create!(name: 'BS', description: 'Filling the void in your life', unit_price: 11999, merchant_id: merchant1.id)
      merch2item = Item.create!(name: 'Impracticality', description: 'Underselling the other guy', unit_price: 11998, merchant_id: merchant2.id)

      visit "/merchants/#{merchant1.id}/items/#{item1.id}"
      # visit merchant_items_path(merchant1, m1i1)
      expect(page).to have_content('Crap')
      expect(page).to have_button('Update')
      click_button('Update')

      expect(current_path).to eq("/merchants/#{merchant1.id}/items/#{item1.id}/edit")

      fill_in 'Name', with: 'Frivilous'
      click_on 'Submit'

      expect(current_path).to eq("/merchants/#{merchant1.id}/items/#{item1.id}")

      expect(page).to have_content('Successfully Updated')
      expect(page).to have_content('Frivilous')
      expect(page).to_not have_content('Crap')
    end

    it 'has buttons to enable or disable the item' do
      merchant1 = Merchant.create!(name: 'Fake Merchant', status: 'Enabled')
      merchant2 = Merchant.create!(name: 'Another Merchant', status: 'Enabled')
      merchant3 = Merchant.create!(name: 'Faux Merchant', status: 'Enabled')

      item1 = Item.create!(name: 'Crap', description: 'Because you buy stuff for no reason', unit_price: 9999, merchant_id: merchant1.id, status: 1)
      item2 = Item.create!(name: 'Junk', description: 'You have room', unit_price: 10999, merchant_id: merchant1.id, status: 0)
      item3 = Item.create!(name: 'BS', description: 'Filling the void in your life', unit_price: 11999, merchant_id: merchant1.id, status: 1)
      merch2item = Item.create!(name: 'Impracticality', description: 'Underselling the other guy', unit_price: 11998, merchant_id: merchant2.id, status: 1)

      visit "/merchants/#{merchant1.id}/items"

      within "#item-0" do
        expect(page).to have_content('Item Name: Crap')
        expect(page).to have_button('Disable')
      end

      within "#item-1" do
        expect(page).to have_content('Item Name: Junk')
        expect(page).to have_button('Enable')
      end

      within "#item-2" do
        expect(page).to have_content('Item Name: BS')
        expect(page).to have_button('Disable')

        click_button('Disable')
        expect(current_path).to eq("/merchants/#{merchant1.id}/items")
        expect(page).to have_button('Enable')
      end

      expect(page).to_not have_content('Impracticality')

      visit "/merchants/#{merchant2.id}/items"

      within "#item-0" do
        expect(page).to have_content('Item Name: Impracticality')
        expect(page).to have_button('Disable')
      end
    end
  end
end
