require 'rails_helper'

RSpec.describe 'Merchant Items Index page' do
  describe '#User story 35' do
    it 'shows a list of all the items of one merchant' do
      merchant1 = Merchant.create!(name: 'Primate Privleges')
      merchant2 = Merchant.create!(name: 'Sandras Affairs')
      item1 = merchant1.items.create!(name: 'Monkey Paw', description: 'A furry mystery', unit_price: 3)
      item2 = merchant1.items.create!(name: 'Gorilla Grip Glue', description: 'A sticky mystery', unit_price: 7)
      item3 = merchant2.items.create!(name: 'Rodrigo Rippers', description: 'IYKYK', unit_price: 900)

      visit "/merchants/#{merchant1.id}/items"
      expect(page).to have_content('Monkey Paw')
      expect(page).to have_content('Gorilla Grip Glue')
      expect(page).to_not have_content('Rodrigo Rippers')
    end
  end

  describe '#User story #32' do
    it 'can enable an item' do
      merchant1 = Merchant.create!(name: 'Primate Privleges')
      item1 = merchant1.items.create!(name: 'Monkey Paw', description: 'A furry mystery', unit_price: 3)
      item2 = merchant1.items.create!(name: 'Gorilla Grip Glue', description: 'A sticky mystery', unit_price: 7)

      visit "/merchants/#{merchant1.id}/items"

      within("div.item_#{item1.id}") do
        expect(page).to have_button("Disable #{item1.name}")
        click_button("Disable #{item1.name}")

        expect(current_path).to eq("/merchants/#{merchant1.id}/items")

        expect(page).to have_button("Enable #{item1.name}")
        item1.reload
        expect(item1.status).to eq('disabled')
      end
    end

    it 'can disable an item' do
      merchant1 = Merchant.create!(name: 'Primate Privleges')
      item1 = merchant1.items.create!(name: 'Monkey Paw', description: 'A furry mystery', unit_price: 3)
      item2 = merchant1.items.create!(name: 'Gorilla Grip Glue', description: 'A sticky mystery', unit_price: 7)

      visit "/merchants/#{merchant1.id}/items"

      within("div.item_#{item1.id}") do
        click_button("Disable #{item1.name}")
        expect(page).to have_button("Enable #{item1.name}")
        click_button("Enable #{item1.name}")

        expect(current_path).to eq("/merchants/#{merchant1.id}/items")

        expect(page).to have_button("Disable #{item1.name}")
        item1.reload
        expect(item1.status).to eq('enabled')
      end
    end
  end

  describe '#User story #31' do
    it 'seperates enabled and disabled items' do
      merchant1 = Merchant.create!(name: 'Primate Privleges')
      item1 = merchant1.items.create!(name: 'Monkey Paw', description: 'A furry mystery', unit_price: 3)
      item2 = merchant1.items.create!(name: 'Gorilla Grip Glue', description: 'A sticky mystery', unit_price: 7,
                                      status: 1)

      visit "/merchants/#{merchant1.id}/items"
      expect(page).to have_content('Enabled Items')
      expect(page).to have_content('Disabled Items')
      expect('Disabled Items').to appear_before(item2.name)
      expect('Enabled Items').to appear_before(item1.name)
    end
  end
  describe '#User story #30' do
    it 'can create a new item' do
      merchant1 = Merchant.create!(name: 'Primate Privleges')
      item1 = merchant1.items.create!(name: 'Monkey Paw', description: 'A furry mystery', unit_price: 3)
      item2 = merchant1.items.create!(name: 'Gorilla Grip Glue', description: 'A sticky mystery', unit_price: 7)
      visit "/merchants/#{merchant1.id}/items"

      expect(page).to have_content('Create New Item')
      click_link('Create New Item')
      expect(current_path).to eq("/merchants/#{merchant1.id}/items/new")

      fill_in 'item_name', with: 'Chimpanzee Cheese'
      fill_in 'item_description', with: 'banana flavored cheese'
      fill_in 'item_unit_price', with: 2122
      click_on('Submit')

      expect(current_path).to eq("/merchants/#{merchant1.id}/items")
      expect(page).to have_content('Chimpanzee Cheese')
    end
  end
end
