require 'rails_helper'

describe 'When I visit the admin dashboard (/admin)' do
  it 'Then I see a link to the admin merchants index (/admin/merchants)' do
    visit "/admin"
    save_and_open_page
    expect(page).to have_link("Merchants")
    click_link("Merchants")
    expect(current_path).to eq("/admin/merchants")
  end

  it 'Then I see a link to the admin merchants index (/admin/merchants)' do
    visit "/admin"

    expect(page).to have_link("Invoices")
    click_link("Invoices")
    expect(current_path).to eq("/admin/invoices")
  end
end
