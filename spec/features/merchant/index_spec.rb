require 'rails_helper'

RSpec.describe 'As a Merchant', type: :feature do
  describe 'When i visit merchant dashboard' do
    it 'list the name of my merchant' do
      @merchant = Merchant.create!(name: "Lizzy")

      visit merchant_dashboard_index_path(@merchant)
      expect(page).to have_content(@merchant.name)
    end
  end
end
