require 'rails_helper'

RSpec.describe 'admin dashboard' do
  it 'has a header' do
    visit admin_path

    expect(page).to have_content('Admin Dashboard')
  end

  it 'has links to admin merchants and admin invoices' do
    visit admin_path

    expect(page).to have_link('Dashboard', href: admin_path)
    expect(page).to have_link('Merchants', href: '/admin/merchants')
    expect(page).to have_link('Invoices', href: '/admin/invoices')
  end
end