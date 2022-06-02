require 'rails_helper'

describe "Admin Dashboad" do
  before do
    visit admin_index_path
  end

  it "displays a header indicating that the user is on the admin dashboard" do

    expect(page).to have_content("Welcome to the Admin Dashboard")
  end

  it "displays links to the admin merchants index and admin invoices index" do
    click_link("Merchants Index")
    expect(current_path).to eq(admin_merchants_path)

    visit admin_index_path
    click_link("Invoices Index")
    expect(current_path).to eq(admin_invoices_path)
  end

end
