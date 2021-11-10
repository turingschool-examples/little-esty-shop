require 'rails_helper'

RSpec.describe 'Admin Merchant Index' do
  it 'has sections for enabled and disabled merchants' do
    merchant1 = Merchant.create!(name: 'Jimmy Pesto')

    visit '/admin/merchants'

    expect(page).to have_content("Enabled Merchants")
    expect(page).to have_content("Disabled Merchants")

    save_and_open_page
    within "#Enabled" do
      expect(page).to have_content(merchant1.name)
    end
  end
end

# As an admin,
# When I visit the admin merchants index
# Then I see two sections, one for "Enabled Merchants" and one for "Disabled Merchants"
# And I see that each Merchant is listed in the appropriate section
