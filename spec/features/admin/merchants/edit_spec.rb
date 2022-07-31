require 'rails_helper'

RSpec.describe 'admin merchant edit page' do

  it 'has a form filled in with the existing merchant attribute information' do
    merchant1 = Merchant.create!(name: "Trader Joes")

    visit edit_admin_merchant_path(merchant1)

    # save_and_open_page

    expect(page).to have_field('Name', with: "Trader Joes")
  end

  it 'when user changes information and clicks submit, they are redirected back to the admin show page where they see the updated information and flash message stating that the information has been successfully updated' do

    merchant1 = Merchant.create!(name: "Trader Joes")

    visit edit_admin_merchant_path(merchant1)

    fill_in "Name", with: "Snacks-a-Plenty"

    click_button "Update Merchant"

    expect(current_path).to eq(admin_merchant_path(merchant1))

    expect(page).to have_content("Snacks-a-Plenty")
    expect(page).to have_content("Information successfully updated!")
  end

end

# Admin Merchant Update

# As an admin,
# When I visit a merchant's admin show page
# Then I see a link to update the merchant's information.
# When I click the link
# Then I am taken to a page to edit this merchant
# And I see a form filled in with the existing merchant attribute information
# When I update the information in the form and I click ‘submit’
# Then I am redirected back to the merchant's admin show page where I see the updated information
# And I see a flash message stating that the information has been successfully updated.