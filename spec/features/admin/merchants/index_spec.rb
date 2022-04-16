require 'rails_helper'
require 'rspec'

describe "the admin/merchants index page" do
  before (:each) do
    @targay = Merchant.create!(name: "Targay", status: 1)
    @walbart = Merchant.create!(name: "Walbart", status: 1)
    @sauer = Merchant.create!(name: "Sauer and Sons", status: 0)
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

      within("#merchant-#{@targay.id}") do
        click_on "Targay"
      end

      expect(current_path).to eq("/admin/merchants/#{@targay.id}")
      expect(page).to have_content("Targay")
    end

    it "displays a button to disable/enable merchant" do
      visit "/admin/merchants"

      expect(page).to have_button("Enable")
      expect(page).to have_button("Disable")
    end

    it "displays enabled merchants" do
      visit "/admin/merchants"

      within("#enabled_merchants") do
        expect(page).to have_content("Targay")
        expect(page).to have_content("Walbart")
        expect(page).to_not have_content("Sauer and Sons")
      end
    end

    it "displays disabled merchants" do
      visit "/admin/merchants"

      within("#disabled_merchants") do
        expect(page).to have_content("Sauer and Sons")
        expect(page).to_not have_content("Targay")
        expect(page).to_not have_content("Walbart")
      end
    end
  end

  describe "when I click the disable/enable button" do
    it "I am redirected back to the admin merchants index page" do
      visit "/admin/merchants"
      within("#merchant-#{@targay.id}") do
        click_on "Disable"
      end
      expect(current_path).to eq("/admin/merchants")
    end

    it "displays the merchants status has changed" do
      visit "/admin/merchants"

      within("#enabled_merchants") do
        expect(page).to have_content("Targay")
      end

      within("#disabled_merchants") do
        expect(page).to_not have_content("Targay")
      end

      within("#merchant-#{@targay.id}") do
        click_on "Disable"
      end

      within("#enabled_merchants") do
        expect(page).to_not have_content("Targay")
      end

      within("#disabled_merchants") do
        expect(page).to have_content("Targay")
      end
    end
  end

  describe "I see a link to create a new merchant" do
    it "takes me to a new page to fill out a form" do
      visit "/admin/merchants"

      click_on "Create New Merchant"

      expect(current_path).to eq("/admin/merchants/new")
    end

    it "allows me to create a new merchant" do
      visit "/admin/merchants"
save_and_open_page
      expect(page).to_not have_content("New merch")

      click_on "Create New Merchant"

      fill_in(:name, with: "New merch")

      click_on "Submit"
save_and_open_page
      expect(current_path).to eq("/admin/merchants")
      expect(page).to have_content("New merch")
      within("#disabled_merchants") do
        expect(page).to have_content("New merch")
      end
    end
  end
end
