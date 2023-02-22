require 'rails_helper'

RSpec.describe 'merchant show dashboard index page', type: :feature do
  describe "as a merchant visiting '/merchants/merchant_id/dashboard'" do
    let!(:merchant1) {Merchant.create!(uuid: 101, name: "Brian's Beads")}
    
    it 'shows my name(merchant)' do
      
      visit "/merchants/#{merchant1.id}/dashboard"

      expect(page).to have_content("Brian's Beads")
    end
  end
end