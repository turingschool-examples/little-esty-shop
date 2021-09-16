require "rails_helper"


RSpec.describe 'merchant edit page' do

  it 'can edit a merchant' do
    merchant = create(:merchant)

    visit edit_admin_merchant_path(merchant)

    fill_in 'name', with: 'Ted'
    click_button 'edit'

    expect(current_path).to eq(admin_merchant_path(merchant))
    expect(page).to have_content('Ted')
    expect(page).to have_content("Merchant updated")

  end

end
# And I see a form filled in with the existing merchant attribute information
# When I update the information in the form and I click ‘submit’
# Then I am redirected back to the merchant's admin show page where I see the updated information
# And I see a flash message stating that the information has been successfully updated.
