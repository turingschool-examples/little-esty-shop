require "rails_helper"

RSpec.describe "Admin Dashboard (Index", type: :feature do
  
  before(:each) do

  end

  it "has a header indicating that the user is on the admin dashboard" do
    visit "/admin"
    expect(page).to have_content("Admin Dashboard")
  end

  it "has a link to the admin merchants index" do
    visit "/admin"
    expect(page).to have_link("Admin Merchants", href: "/admin/merchants")
  end

  it "has a link to the admin invoices index" do
    visit "/admin"
    expect(page).to have_link("Admin Invoices", href: "/admin/invoices")
  end

  it "has a list of the top 5 customers who have conducted the largest unmber of successful
    transactions" do
      visit "/admin"

  end

  it "next to each of the top 5 customers it has the number of successful transactions they
    have conducted" do
      visit "/admin"

  end

end