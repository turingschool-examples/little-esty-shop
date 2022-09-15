require 'rails_helper'

RSpec.describe "As an admin, when I visit the admin dashboard (/admin)", type: :feature do
  it "I see a header indicating that I am on the admin dashboard" do
    visit admin_index_path

    within("#admin_title") do
      expect(page).to have_content "Admin Dashboard"
    end
  end

  it "I see a link to the admin merchants index (/admin/merchants)" do
    visit admin_index_path

    within("#admin_links") do
      expect(page).to have_link("Merchants")
    end
  end

  it "I see a link to the admin invoices index (/admin/invoices)" do
    visit admin_index_path

    within("#admin_links") do
      expect(page).to have_link("Invoices")
    end
  end

  xit "Then I see the names of the top 5 customers who have conducted the largest number of successful transactions" do
    visit admin_index_path

    expect(page).to have_content("")

  end

  xit "And next to each customer name I see the number of successful transactions they have conducted" do

  end
end
