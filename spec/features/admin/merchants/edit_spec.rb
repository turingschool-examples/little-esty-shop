require "rails_helper"

RSpec.describe 'merchant edit page' do

  it 'edits a merchants name' do
    merchant = Merchant.create(name: "Test")

    visit edit_admin_merchant_path(merchant)

    fill_in 'merchant_name', with: 'It worked!'
    click_button 'Edit'

    expect(current_path).to eq(admin_merchant_path(merchant))
    expect(page).to have_content(merchant.name)
  end
end
