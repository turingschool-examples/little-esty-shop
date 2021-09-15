require 'rails_helper'
# As an admin,
# When I visit the admin merchants index (/admin/merchants)
# Then I see the name of each merchant in the system
RSpec.describe 'admin merchants index page' do
  it "shows every merchant" do
    merchant_1 = Merchant.create!(name: 'Weston')
    merchant_2 = Merchant.create!(name: 'Ted')

    visit '/admin/merchants/'

    expect(page).to have_content(merchant_1.name)
    expect(page).to have_content(merchant_2.name)
  end
end
