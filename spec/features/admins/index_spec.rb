require 'rails_helper'

RSpec.describe 'the admin index' do
  it 'shows the admin dashboard' do
    visit '/admin'
    expect(current_path).to eq('/admin')

    expect(page).to have_content("Admin Dashboard")
  end

  it 'has links to admin merchants and admin invoices index' do
    visit '/admin'
    expect(current_path).to eq('/admin')

    expect(page).to have_link('Merchants')
    click_link('Merchants')
    expect(current_path).to eq("/admin/merchants")

    visit '/admin'

    expect(page).to have_link('Invoices')
    click_link('Invoices')
    expect(current_path).to eq("/admin/invoices")
  end
end
