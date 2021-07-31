require 'rails_helper'

RSpec.describe 'Admin Invoice Show Page' do
  # As an admin,
  # When I visit an admin invoice show page
  # Then I see information related to that invoice including:
  # - Invoice id
  # - Invoice status
  # - Invoice created_at date in the format "Monday, July 18, 2019"
  # - Customer first and last name
  it 'shows an invoice with attributes' do
    visit admin_invoice_path("#{@invoice1.id}")

    expect(page).to have_content("#{@invoice1.id}")
    expect(page).to have_content("#{@invoice1.status}")
    expect(page).to have_content('Created At: Sunday, March 25, 2012')
    expect(page).to have_content("#{@customer1.first_name}")
    expect(page).to have_content("#{@customer1.last_name}")

    expect(page).to_not have_content("#{@invoice7.id}")
    expect(page).to_not have_content("#{@invoice7.status}")
    expect(page).to_not have_content('Created At: Wednesday, March 7, 2012')
    expect(page).to_not have_content("#{@customer2.first_name}")
    expect(page).to_not have_content("#{@customer2.last_name}")
  end
end
