require 'rails_helper'

RSpec.describe 'edit', type: :feature do
  describe "when merchant visit /merchants/merchant_id/items" do
    let!(:schroeder_jerde) { Merchant.create!(name: 'Schroeder-Jerde')}
    let!(:qui) {Item.create!(merchant: schroeder_jerde, name: 'Qui Esse', unit_price: 75107, description: "Cooling") }
    let!(:autem) {Item.create!(merchant: schroeder_jerde, name: 'Autem Minima', unit_price: 67076, description: "Sweet") }
    let!(:ea) {Item.create!(merchant: schroeder_jerde, name: 'Ea Voluptatum', unit_price: 32301, description: "Soft")}

    it "can edit items and after submit redirect to '/merchants/merchant_id/items/item_id'" do
      visit "/merchants/#{schroeder_jerde.id}/items/#{qui.id}"

      within "#item-#{qui.id}" do
        expect(page).to have_content("Name: Qui Esse")
        expect(page).to have_content("Description: Cooling")
        expect(page).to have_content("Unit Price: 75107")
        click_link("Edit Item")
      end
      expect(current_path).to eq "/merchants/#{schroeder_jerde.id}/items/#{qui.id}/edit"

      expect(page).to have_content("Edit Merchant Item")
      fill_in("Name", with: "Qui Esse")
      fill_in("Description", with: "refreshing")
      fill_in("Unit Price", with: 70500)
      click_button("Submit")

      expect(current_path).to eq "/merchants/#{schroeder_jerde.id}/items/#{qui.id}"
      expect(page).to have_content("Name: Qui Esse")
      expect(page).to have_content("Description: refreshing")
      expect(page).to have_content("Unit Price: 70500")
    end
  end
end
