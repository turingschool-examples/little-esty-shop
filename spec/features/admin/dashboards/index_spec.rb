require 'rails_helper'
RSpec.describe 'it can display the dashboards index page' do
  before :each do
    visit "/admin"
  end

  it 'can show the Header of the index page' do
    expect(page).to have_content("Admin Dashboard")
  end

  it 'shows the links to the admin merchants and the admin invoices' do
    expect(page).to have_link("Merchants: Index page")
    expect(page).to have_link("Invoices: Index page")
  end

  it 'can click on the index links and be on that specified index page' do
    
    click_link("Merchants: Index page")
    expect(current_path).to eq("/admin/merchants")

    visit "/admin"

    click_link("Invoices: Index page")
    expect(current_path).to eq("/admin/invoices")
  end
end