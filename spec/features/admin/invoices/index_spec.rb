require 'rails_helper'

RSpec.describe 'Admin Invoices Index Page' do
  # As an admin,
  # When I visit the admin Invoices index ("/admin/invoices")
  # Then I see a list of all Invoice ids in the system
  # Each id links to the admin invoice show page
  it 'lists all invoice ids in the system' do
    antonio = Customer.create!(first_name: 'Antonio', last_name: 'King')
    maria = Customer.create!(first_name: 'Maria', last_name: 'Marks')
    inv_1 = Invoice.create!(status: 0, customer_id: antonio.id)
    inv_2 = Invoice.create!(status: 1, customer_id: antonio.id)
    inv_3 = Invoice.create!(status: 2, customer_id: maria.id)

    visit '/admin/invoices'

    expect(page).to have_content(inv_1.id)
    expect(page).to have_content(inv_2.id)
    expect(page).to have_content(inv_3.id)
  end

  xit 'has links for each invoice id that link to respective show pages' do
    antonio = Customer.create!(first_name: 'Antonio', last_name: 'King')
    maria = Customer.create!(first_name: 'Maria', last_name: 'Marks')
    inv_1 = Invoice.create!(status: 'in progress', customer_id: antonio.id)
    inv_2 = Invoice.create!(status: 'completed', customer_id: antonio.id)
    inv_3 = Invoice.create!(status: 'cancelled', customer_id: maria.id)

    visit '/admin/invoices'

    expect(page).to have_link(inv_1.id)
    expect(page).to have_link(inv_2.id)
    expect(page).to have_link(inv_3.id)

    click_on(inv_1.id)

    expect(current_path).to eq("/admin/invoices/#{inv_1.id}")
  end
end
