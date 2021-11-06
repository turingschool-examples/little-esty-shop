require 'rails_helper'

RSpec.describe "admin merchant edit" do
  before do
    @merchant = create(:merchant)
    visit edit_admin_merchant_path(@merchant)
  end

  it 'can edit a merchant' do
    fill_in 'Name', with: "Stephanie's Shop"
    click_button "Submit"

    expect(current_path).to eq(admin_merchant_path(@merchant))
    expect(page).to have_content("Stephanie's Shop")
    expect(page).to have_content("Merchant has been updated.")
  end
end

  # Admin Merchant Update
  #
  # As an admin,
  # When I visit a merchant's admin show page
  # Then I see a link to update the merchant's information.
  # When I click the link
  # Then I am taken to a page to edit this merchant
  # And I see a form filled in with the existing merchant attribute information
  # When I update the information in the form and I click ‘submit’
  # Then I am redirected back to the merchant's admin show page where I see the updated information
  # And I see a flash message stating that the information has been successfully updated.
