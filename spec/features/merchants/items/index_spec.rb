require 'rails_helper'

RSpec.describe 'index', type: :feature do
  describe "when merchant visit 'merchants/merchant_id/items'" do
    let!(:schroeder_jerde) { Merchant.create!(name: 'Schroeder-Jerde')}
    let!(:qui) {Item.create!(merchant: schroeder_jerde, name: 'Qui Esse', unit_price: 75107) }
    let!(:autem) {Item.create!(merchant: schroeder_jerde, name: 'Autem Minima', unit_price: 67076) }
    let!(:ea) {Item.create!(merchant: schroeder_jerde, name: 'Ea Voluptatum', unit_price: 32301) }

    it "should see a list of all that merchant items and not other merchan
    t items" do
      visit "/merchants/#{schroeder_jerde.id}/items"
      expect(page).to have_content(qui.name)
      expect(page).to have_content(autem.name)
      expect(page).to have_content(ea.name)
    end
  end
end