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


  it 'can enable and disable merchants' do
    visit admin_merchants_path

    within('#enabled-merchants') do
      expect(page).to have_content("Disable: #{merchant_1.name}")
      expect(page).to have_content("Disable: #{merchant_2.name}")

      click_button "Disable: #{merchant_1.name}"
    end

    expect(current_path).to eq(admin_merchants_path)

    within('#disbled-merchants') do
      expect(page).to have_content("Enable: #{merchant_1.name}")

      click_button "Enable: #{merchant_1.name}"
    end

    expect(current_path).to eq(admin_merchants_path)

    within('#enabled-merchants') do
      expect(page).to have_content("Disable: #{merchant_1.name}")
    end
  end
#   As an admin,
# When I visit the admin merchants index
# Then next to each merchant name I see a button to disable or enable that merchant.
# When I click this button
# Then I am redirected back to the admin merchants index
# And I see that the merchant's status has changed
end
