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
      expect(page).to have_content("#{qui.name}")
      expect(page).to have_content("#{qui.description}")
      expect(page).to have_content("#{qui.unit_price}")
      save_and_open_page
    end
  end
end