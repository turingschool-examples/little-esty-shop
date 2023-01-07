require 'rails_helper'

RSpec.describe 'admin merchants index' do
  before :each do
    @merchants = FactoryBot.create_list(:merchant, 3)
  end

  describe 'User Story 24 & 25' do
    it 'shows the name of all merchants with links to admin merchant show' do
      visit admin_merchants_path

      expect(page).to have_link(@merchants.first.name, href: admin_merchant_path(@merchants.first))
      expect(page).to have_link(@merchants.second.name, href: admin_merchant_path(@merchants.second))
      expect(page).to have_link(@merchants.third.name, href: admin_merchant_path(@merchants.third))
    end
  end
end