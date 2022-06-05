require 'rails_helper'

RSpec.describe "Admin Merchants Index Page" do
  let!(:merchant1) { Merchant.create!(name: "REI") }
  let!(:merchant2) { Merchant.create!(name: "Target") }
  let!(:merchant3) { Merchant.create!(name: "Walgreens") }
  let!(:merchant4) { Merchant.create!(name: "Hot Topic", status: 1) }

  before do
    visit admin_merchants_path
  end

  it "displays the name of each merchant in the system" do
    expect(page).to have_content("Admin Merchants Index")

    within ".disabled-merchants" do
      expect(page).to have_content("REI")
      expect(page).to have_content("Target")
      expect(page).to have_content("Walgreens")
      expect(page).to_not have_content("Hot Topic")
    end

    within ".enabled-merchants" do
      expect(page).to have_content("Hot Topic")
      expect(page).to_not have_content("REI")
      expect(page).to_not have_content("Target")
      expect(page).to_not have_content("Walgreens")
    end
  end

  it "can fill out a form to create a new merchant and display the default status of disabled" do
    expect(page).to_not have_content('Backcountry')

    click_link "Create a New Merchant"
    expect(current_path).to eq(new_admin_merchant_path)

    fill_in :name, with: 'Backcountry'
    click_on "Submit"

    expect(current_path).to eq(admin_merchants_path)

    within ".disabled-merchants" do
      expect(page).to have_content('Backcountry')
      expect(page).to have_content('Status: Disabled')
    end
  end

  it "displays a link to create a new merchant" do
    expect(page).to have_link('New Merchant')
  end
end
