require 'rails_helper'

RSpec.describe 'admin invoices index' do
  before(:each) do
    @customer1 = Customer.create!(first_name: 'Cowboy', last_name: 'Smith')
    @customer2 = Customer.create!(first_name: 'Mercy', last_name: 'Champion')
    @invoice1 = Invoice.create!(status: 0, customer_id: "#{@customer1.id}")
    @invoice2 = Invoice.create!(status: 0, customer_id: "#{@customer1.id}")
    @invoice3 = Invoice.create!(status: 0, customer_id: "#{@customer2.id}")
  end

  it 'shows a list of all Invoice ids in the system' do
    visit '/admin/invoices'
    expect(page).to have_content(@invoice1.id)
    expect(page).to have_content(@invoice2.id)
    expect(page).to have_content(@invoice3.id)
  end

  it 'id is a link to the invoice show page' do
    visit '/admin/invoices'
    expect(page).to have_link("#{@invoice1.id}")
    expect(page).to have_link("#{@invoice2.id}")
    expect(page).to have_link("#{@invoice3.id}")
  end
end

# As an admin,
# When I visit the admin Invoices index ("/admin/invoices")
# Then I see a list of all Invoice ids in the system
# Each id links to the admin invoice show page


