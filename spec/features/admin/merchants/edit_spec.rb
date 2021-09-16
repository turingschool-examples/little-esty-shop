require "rails_helper"


RSpec.describe 'merchant edit page' do

  it 'can edit a merchant' do
    merchant = create(:merchant)

    visit edit_admin_merchant_path(merchant)

    fill_in 'merchant_name', with: 'Ted'
    click_button 'Edit'

    expect(current_path).to eq(admin_merchant_path(merchant))
    expect(page).to have_content('Ted')
    expect(page).to have_content("Merchant updated")

  end

end
