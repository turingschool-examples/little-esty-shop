require 'rails_helper'

RSpec.describe 'Admin Index' do
  it 'has a header that lets the user know they are on the admin dashboard' do
    visit admin_index_path

    expect(page).to have_content('Admin Dashboard')
  end

  it 'has a link to the admin merchants page' do
    visit admin_index_path

    click_link "Merchants"

    expect(current_path).to eq('/admin/merchants')
  end
  
  it 'has a link to the admin invoices page' do
    visit admin_index_path
    
    click_link "Invoices"
    
    expect(current_path).to eq('/admin/invoices')
  end
end