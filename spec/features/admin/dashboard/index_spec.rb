require 'rails_helper'

RSpec.describe 'admin dashboard' do
  before :each do
    visit '/admin'
  end

  it "has a header letting you know it's the admin dash" do

    expect(page).to have_content("Admin Dashboard")
  end

  it "has links to the merchant and invoice index pages" do
    expect(page).to have_link("merchants")
    expect(page).to have_link("invoices")
  end

  it "has a working merchants index link" do
    click_link "merchants"
    expect(current_path).to eq("/admin/merchants")
  end

  it "has a working invoices index link" do
    click_link "invoices"
    expect(current_path).to eq("/admin/invoices")
  end

end
