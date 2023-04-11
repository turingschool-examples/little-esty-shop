# 1. Merchant Dashboard

# As a merchant,
# When I visit my merchant dashboard (/merchants/merchant_id/dashboard)
# Then I see the name of my merchant
require 'rails_helper'

RSpec.describe 'Merchant Show Dashboard Page', type: :feature do
  let!(:merchant1) {Merchant.create!(name:'Steve')}
  let!(:merchant2) {Merchant.create!(name:'Fred')}

  describe "As a merchant visiting '/merchants/:id/dashboard'" do
    it 'I see the name of my merchant' do
      visit merchant_dashboard_path(merchant1)
      # save_and_open_page

      expect(page).to have_content('Steve')
    end
  end
end

