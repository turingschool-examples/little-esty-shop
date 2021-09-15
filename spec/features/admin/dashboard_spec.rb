require 'rails_helper'

RSpec.describe 'admin dashboard page' do
  it "has a header" do

    visit '/admin'

    expect(page).to have_content('Admin Dashboard')
  end

#   Admin Dashboard Links
#
# As an admin,
# When I visit the admin dashboard (/admin)
# Then I see a link to the admin merchants index (/admin/merchants)
# And I see a link to the admin invoices index (/admin/invoices)

  it "has links to merchants and invoices" do
    visit '/admin'

    expect(page).to have_link('Merchants')
    expect(page).to have_link('Invoices')

    click_on 'Merchants'

    expect(current_path).to eq('/admin/merchants')

    visit '/admin'

    click_on 'Invoices'
    
    expect(current_path).to eq('/admin/invoices')
  end
end
