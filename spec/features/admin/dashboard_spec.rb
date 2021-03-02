require "rails_helper"

RSpec.describe "When I visit '/admin' I see the admin dashboard" do
  it "displays dashboard header" do
    visit admin_index_path

    expect(page).to have_content("This is the Admin Dashboard")
  end

  it "Shows links for admin/merchants & admin/invoices" do
    visit admin_index_path

    expect(page).to have_link("Admin Merchants Index")
    expect(page).to have_link("Admin Invoices Index")
  end
end
