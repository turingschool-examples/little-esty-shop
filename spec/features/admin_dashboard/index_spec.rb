require 'rails_helper'

RSpec.describe 'Admin Dashboard' do
  before :each do
    @customer1 = Customer.create!(first_name: "Bob", last_name: "Gu")
    @customer2 = Customer.create!(first_name: "Steve", last_name: "Smith")
    @customer3 = Customer.create!(first_name: "Jill", last_name: "Biden")
    @customer4 = Customer.create!(first_name: "Adriana", last_name: "Green")
    @customer5 = Customer.create!(first_name: "Sally", last_name: "May")
    @customer6 = Customer.create!(first_name: "Tim", last_name: "Tebow")
  end

  it 'When I visit admin dashboard I see a header
   indicating that I am on the admin dashboard' do

    visit '/admins'

    expect(page).to have_content("Admin Dashboard")
    expect(page).to have_link("Admin Merchants Index")
    expect(page).to have_link("Admin Invoices Index")
  end

  it 'I see the names of the top 5 customers' do
    visit '/admins'

    expect(page).to have_content(@customer1.name)
    expect(page).to have_content(@customer2.name)
    expect(page).to have_content(@customer3.name)
    expect(page).to have_content(@customer4.name)
    expect(page).to have_content(@customer5.name)
    expect(page).to_not have_content(@customer6.name)
  end
# Then I see the names of the top 5 customers
# who have conducted the largest number of successful transactions
# And next to each customer name I see the number of successful transactions they have
# conducted with my merchant
end
