require 'rails_helper'

RSpec.describe 'show', type: :feature do
  describe "when merchant visit /merchants/merchant_id/items" do
    let!(:schroeder_jerde) { Merchant.create!(name: 'Schroeder-Jerde')}
    let!(:qui) {Item.create!(merchant: schroeder_jerde, name: 'Qui Esse', unit_price: 75107, description: "Cooling") }
    let!(:autem) {Item.create!(merchant: schroeder_jerde, name: 'Autem Minima', unit_price: 67076, description: "Sweet") }
    let!(:ea) {Item.create!(merchant: schroeder_jerde, name: 'Ea Voluptatum', unit_price: 32301, description: "Soft")}

    it 'should see all attributes of the items' do
      visit "/merchants/#{schroeder_jerde.id}/items"
      click_link("#{qui.name}")
      expect(current_path).to eq("/merchants/#{schroeder_jerde.id}/items/#{qui.id}")
      expect(page).to have_content("Name: #{qui.name}")
      expect(page).to have_content("Description: #{qui.description}")
      expect(page).to have_content("Unit Price: #{qui.unit_price}")
    end

    # As a merchant,
    # When I visit the merchant show page of an item
    # I see a link to update the item information.
    # When I click the link
    # Then I am taken to a page to edit this item
    # And I see a form filled in with the existing item attribute information
    # When I update the information in the form and I click ‘submit’
    # Then I am redirected back to the item show page where I see the updated information
    # And I see a flash message stating that the information has been successfully updated.
    it 'have form to update and edit the item' do
      visit "/merchants/#{schroeder_jerde.id}/items/#{qui.id}"

      within "#item-#{qui.id}" do
        expect(page).to have_link("Edit Item", href: "/merchants/#{schroeder_jerde.id}/items/#{qui.id}/edit")
        click_link("Edit Item")
      end
      expect(current_path).to eq("/merchants/#{schroeder_jerde.id}/items/#{qui.id}/edit")
    end
  end
end