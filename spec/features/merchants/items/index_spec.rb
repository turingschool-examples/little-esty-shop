require 'rails_helper'

RSpec.describe 'Merchant Items Index page' do
  describe '#User story 35' do
    it 'shows a list of the names of all of my items and no other merchants items' do
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
    xit 'can enable an item' do
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
  end
end
