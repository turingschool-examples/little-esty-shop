require 'rails_helper'

describe 'Admin Dashboard Index Page' do
  before :each do 
    visit admin_dashboard_index_path
  end

  it 'should display a header indicating the admin dashboard' do
    expect(page).to have_content('Admin Dashboard')
  end

  it 'should have link to admin merchant index' do
    expect(page).to have_link('Merchants')

    click_link 'Merchants'
    expect(current_path).to eq(admin_merchants_path)
  end

  it 'should have link to admin invoice index' do
    expect(page).to have_link('Invoices')

    click_link 'Invoices'
    expect(current_path).to eq(admin_invoices_path)
  end
end