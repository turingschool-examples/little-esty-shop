require 'rails_helper'

RSpec.describe 'admin dashboard page' do

  it "has a header" do

    visit '/admin/dashboard'

    expect(page).to have_content('Admin Dashboard')
  end

  it "has links to merchants and invoices" do
    visit '/admin/dashboard'

    expect(page).to have_link('Merchants')
    expect(page).to have_link('Invoices')

    click_on 'Merchants'

    expect(current_path).to eq('/admin/merchants')

    visit '/admin/dashboard'

    click_on 'Invoices'

    expect(current_path).to eq('/admin/invoices')
  end

#   As an admin,
# When I visit the admin dashboard
# Then I see the names of the top 5 customers
# who have conducted the largest number of successful transactions
# And next to each customer name I see the number of successful transactions they have
# conducted with my merchant

  it "shows the top 5 customers" do
    visit '/admin/dashboard'


  end
end
