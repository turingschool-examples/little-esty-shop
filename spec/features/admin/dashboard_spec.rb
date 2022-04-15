require "rails_helper"

RSpec.describe "admin dashboard" do
  before :all do
    visit "/admin"
  end

  it "exists" do
    expect(page).to have_content("Admin Dashboard")
  end

  it "has link to admin merchants index" do
    click_link("Admin Merchants Index")

    expect(current_path).to eq("/admin/merchants")
  end

  it "has link to admin invoices index" do
    click_link("Admin Invoices Index")

    expect(current_path).to eq("/admin/invoices")
  end
end
