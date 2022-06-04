require 'rails_helper'

# Admin Merchants Index
#
# As an admin,
# When I visit the admin merchants index (/admin/merchants)
# Then I see the name of each merchant in the system

RSpec.describe "Admin Merchants Index Page ", type: :feature do
  describe 'User Story 1 - Admin Merchants Index'
  let!(:merchants) { create_list(:merchant, 2) }

  it "can display all the merchants" do
    visit '/admin/merchants'

    expect(page).to have_content(merchants[0].name)
    expect(page).to have_content(merchants[1].name)

  end
end
