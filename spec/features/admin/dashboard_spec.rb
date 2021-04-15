require 'rails_helper'

RSpec.describe "Admin Dashboard" do
  it "shows header for admin dashboard" do
    visit "/admin"

    expect(page).to have_content("Admin Dashboard")
  end

  it "see links to admin merchants index and admin invoices index" do
    visit "/admin"

    expect(page).to have_link("Merchants")
    expect(page).to have_link("Invoices")
  end

  it "shows top customers in the admin dashboard" do
    visit "/admin"
  end

  it "shows incomplete invoices" do
    visit "/admin"
    expect(page).to have_content("Incomplete Invoices")
  end
end
