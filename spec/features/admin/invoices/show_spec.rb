require 'rails_helper'

RSpec.describe 'admin invoice show page', type: :feature do
  it 'has the invoice: id, status' do
    customer = Customer.create!(first_name: "A", last_name: "AA")
    invoice1 = customer.invoices.create!(status: 'in progress')
    
    visit "/admin/invoices/#{invoice1.id}"
    
    expect(page).to have_content("#{invoice1.id}")
    expect(page).to have_content("#{invoice1.status}")
  end
  
  it "has the customer name, created_at 'Thursday, July 18, 2019'" do
    customer = Customer.create!(first_name: "A", last_name: "AA")
    invoice1 = customer.invoices.create!(status: 'in progress', created_at: 'Thursday, July 18, 2019')
    
    visit "/admin/invoices/#{invoice1.id}"
    expect(page).to have_content(customer.first_name)
    expect(page).to have_content(customer.last_name)
    expect(page).to have_content('Thursday, July 18, 2019')
  end
end