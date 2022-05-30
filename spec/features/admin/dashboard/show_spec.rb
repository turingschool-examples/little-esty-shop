require 'rails_helper'

RSpec.describe "Admin dashboard" do
  it "shows the admin dashboard" do
    visit '/admin'

    expect(page).to have_content "Admin Dashboard"
  end

  it "has links to admin/merchants and admin/invoices" do
    visit '/admin'

    click_link "Admin Merchant Index"
    expect(path).to eq "/admin/merchants"

    visit '/admin'

    click_link "Admin Invoice Index"
    expect(path).to eq "/admin/invoices"
  end
end
