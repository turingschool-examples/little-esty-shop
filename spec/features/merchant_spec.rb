require "rails_helper"

RSpec.describe "the merchant dashboard"  do
  describe "visit my merchant dashboard" do
    it "I see the name of my merchant" do
      merchant1 = Merchant.create!(name: "Bob")

      visit("/merchants/#{merchant1.id}/dashboard")
      expect(page).to have_content("#{merchant1.name}")
    end

    it 'I see link to my merchant items and invoices index' do
      merchant1 = Merchant.create!(name: "Bob")

      visit("/merchants/#{merchant1.id}/dashboard")
      
      expect(page).to have_link('Items Index')
      expect(page).to have_link('Invoices Index')
    end

    it 'I can click on items index link and be directed' do
      merchant1 = Merchant.create!(name: "Bob")

      visit("/merchants/#{merchant1.id}/dashboard")

      click_link 'Items Index'
      expect(current_path).to eq("/merchants/#{merchant1.id}/items")
    end

    it 'I can click the invoices index link and be directed' do
      merchant1 = Merchant.create!(name: "Bob")

      visit("/merchants/#{merchant1.id}/dashboard")

      click_link 'Invoices Index'
      expect(current_path).to eq("/merchants/#{merchant1.id}/invoices")
    end
  end
end
