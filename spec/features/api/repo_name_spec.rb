require 'rails_helper'

RSpec.describe 'Display Repo Name', type: :feature do
  context 'as a visitor or admin' do
    it 'shows the Github repo name on all pages of the site' do
      @starw = Merchant.create!(name: "Star Wars R Us ")
      visit '/admin'

      expect(page).to have_content("Github repo: little-esty-shop")

      visit merchant_items_path(@starw)
      expect(page).to have_content("Github repo: little-esty-shop")

    end
  end
end
