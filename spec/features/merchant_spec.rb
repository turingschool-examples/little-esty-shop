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
  end
end
