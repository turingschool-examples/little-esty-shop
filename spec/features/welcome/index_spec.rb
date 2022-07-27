require 'rails-helper'

RSpec.describe 'welcome page' do
  it 'shows the welcome page' do
    merchant1 = Merchant.create!(name: 'Fake Merchant')
    merchant2 = Merchant.create!(name: 'Another Fake Merchant')
    merchant3 = Merchant.create!(name: 'Faux Merchant')

    item1 = merchant1.items.create!(name: 'Fake Item 1', description: 'wow', unit_price: 4)
    item2 = merchant1.items.create!(name: 'Another thing', description: 'omg', unit_price: 3)
    item3 = merchant2.items.create!(name: 'Faux stuff', description: 'amazing', unit_price: 2)

    visit '/welcome'

    it 'has a link to merchants' do
      expect(page).to have_link("Merchants")

      # click_link("Merchants")
      #
      # expect(page).not_to have_content('Fake Merchant')
      # expect(page).not_to have_content('Fake Item')
    end

    it 'has a link to items' do
      expect(page).to have_link("Items")

      # click_link("Items")
      #
      # expect(page).to have_content('Fake Item')
      # expect(page).to have_content('Another thing')
      # expect(page).not_to have_content('Fake Merchant')
    end
  end
end
