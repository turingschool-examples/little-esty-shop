require 'rails_helper'

RSpec.describe 'Admin Dashboard Page' do
  before :each do 
    visit admin_dashboard_index_path
  end 
  
  scenario 'visitor sees a header' do 
    expect(page).to have_content("Admin Dashboard")
  end

  scenario 'visitor sees a link to the admin merchant index page' do 
    expect(page).to have_link("Merchants", href: admin_merchants_path)

  end 
  
  scenario 'visitor sees a link to the admin invoices index page' do 
    expect(page).to have_link("Invoices", href: admin_invoices_path)
  end 
end 