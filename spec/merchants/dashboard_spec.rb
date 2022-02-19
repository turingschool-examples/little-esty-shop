require 'rails_helper'

 RSpec.describe 'Merchant Dashboard' do
  describe 'user story #40' do
    it "when visiting merchant dashboard I see name of merchant" do
      merchant_1 = Merchant.create!(name: 'Circuit City Jr')

      visit "/merchants/#{merchant_1.id}/dashboard"

      expect(page).to have_content('Circuit City Jr')
    end
  end

  describe 'user story #39' do
    it "when visiting merchant dashboard I see a link to merchant invoices index" do
      merchant_1 = Merchant.create!(name: 'Circuit City Jr')

      visit "/merchants/#{merchant_1.id}/dashboard"
      click_link 'Invoices'

      expect(page).to have_content('Circuit City Jr')
    end
  end


 end
