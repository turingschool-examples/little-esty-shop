require 'rails_helper'

RSpec.describe 'Admin Invoices Index Page' do
  # As an admin,
  # When I visit the admin Invoices index ("/admin/invoices")
  # Then I see a list of all Invoice ids in the system
  # Each id links to the admin invoice show page
  it 'lists all invoice ids in the system' do
    visit '/admin/invoices'

    expect(page).to have_content(@invoice1.id)
    expect(page).to have_content(@invoice2.id)
    expect(page).to have_content(@invoice3.id)
    expect(page).to have_content(@invoice4.id)
    expect(page).to have_content(@invoice5.id)
    expect(page).to have_content(@invoice6.id)
    expect(page).to have_content(@invoice7.id)
    expect(page).to have_content(@invoice11.id)
    expect(page).to have_content(@invoice15.id)
  end

  it 'has links for each invoice id that link to respective show pages' do
    visit '/admin/invoices'

    expect(page).to have_link("#{@invoice1.id}")
    expect(page).to have_link("#{@invoice2.id}")
    expect(page).to have_link("#{@invoice3.id}")
    expect(page).to have_link("#{@invoice4.id}")
    expect(page).to have_link("#{@invoice5.id}")
    expect(page).to have_link("#{@invoice6.id}")
    expect(page).to have_link("#{@invoice7.id}")
    expect(page).to have_link("#{@invoice11.id}")
    expect(page).to have_link("#{@invoice15.id}")

    click_on("#{@invoice1.id}")

    expect(current_path).to eq("/admin/invoices/#{@invoice1.id}")

    visit '/admin/invoices'

    click_on("#{@invoice6.id}")

    expect(current_path).to eq("/admin/invoices/#{@invoice6.id}")

    visit '/admin/invoices'

    click_on("#{@invoice14.id}")

    expect(current_path).to eq("/admin/invoices/#{@invoice14.id}")
  end
end
