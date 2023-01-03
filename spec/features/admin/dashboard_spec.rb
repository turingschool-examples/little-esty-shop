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

  it 'Displays names of top 5 customers by transaction and their transaction count' do
    visit admin_path

    within '#top_customers' do
      expect("Ilene").to appear_before("Katrina")
      expect("Katrina").to appear_before("Ramona")
      expect("Ramona").to appear_before("Parker")
      expect("Parker").to appear_before("Leanne")  
    end

    within '#customer_12' do
      expect(page).to have_content(9)
    end
  end
end