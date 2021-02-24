require 'rails_helper'
describe 'Admin Dashboard' do
  
  it 'displays a header' do
    visit '/admin'

    expect(page).to have_content("Admin Dashboard")
  end

  it 'Shows links to merchant and invoice index pages' do
    visit '/admin'
    
    expect(page).to have_link("Merchant Index")
    expect(page).to have_link("Invoice Index")
  end

  it 'Shows names of top 5 customers with largest number of transactions' do
    visit '/admin'

    expect(page).to have_content()
  end
end