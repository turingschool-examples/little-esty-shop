require 'rails_helper'

RSpec.describe "admin dashboard" do
    it 'has an admin dashboard header ' do

      visit("/admin")

      expect(page).to have_content("Admin Dashboard")
    end

    it "has links to the merchants index and the invoices index" do

      visit("/admin")

      click_on("Merchants")
      expect(current_path).to eq("/admin/merchants")

      visit("/admin")

      click_on("Invoices")
      expect(current_path).to eq("/admin/invoices")
    end
  end
