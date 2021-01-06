require 'rails_helper'

RSpec.describe 'merchant dashboard index', type: :feature do
  describe 'as a merchant' do
    it "when I visit my dashboard, I can see my name" do
      merch_1 =  Merchant.create!(name: "Merch Mark")

      visit merchant_dashboard_index_path(merch_1)

      expect(page).to have_content(merch_1.name)
    end

  end
end
