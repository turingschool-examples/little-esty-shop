require 'rails_helper'

RSpec.describe 'the admin merchant show' do
  describe 'github api' do
    it "has the repo name" do
      merchant_1 = Merchant.create!(name: "Staples")

      visit"/admin/merchants/#{merchant_1.id}/edit"

      within ".github-info" do
        expect(page).to have_content("SullyBirashk/little-esty-shop")
      end
    end
  end

  it "has a form with the existing value for name" do
    merchant_1 = Merchant.create!(name: "Staples")

    visit"/admin/merchants/#{merchant_1.id}/edit"

    within(".update_merchant") do
      expect(page).to have_field(:name, with: "#{merchant_1.name}")
    end
  end

  it "fills in the form and is redirected to show page where the name has changed" do
    merchant_1 = Merchant.create!(name: "Staples")

    visit"/admin/merchants/#{merchant_1.id}/edit"

    within(".update_merchant") do
      fill_in 'name', with: "Sams Club"
      click_on 'Save'
    end

    expect(current_path).to eq("/admin/merchants/#{merchant_1.id}")

    expect(page).to have_content("Sams Club")
    expect(page).to_not have_content("Staples")
    #flash message test
  end
end
