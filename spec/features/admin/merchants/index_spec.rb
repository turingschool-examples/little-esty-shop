require 'rails_helper'
require 'rspec'

describe "the admin/merchants index page" do
  before (:each) do
    @targay = Merchant.create!(name: "Targay")
    @walbart = Merchant.create!(name: "Walbart")
    @sauer = Merchant.create!(name: "Sauer and Sons")
  end

  describe "when I visit the admin/merchants index" do
    it "displays a list of all merchants" do
      visit "/admin/merchants"

      expect(page).to have_content("Targay")
      expect(page).to have_content("Walbart")
      expect(page).to have_content("Sauer and Sons")

    end

    it "has each name as a link to that show page" do
      visit "/admin/merchants"

      click_on "Targay"

      expect(current_path).to eq("/admin/merchants/#{@targay.id}")
      expect(page).to have_content("Targay")
    end
  end
end
