require 'rails_helper'

RSpec.describe 'the admin merchants index' do
  before(:each) do
    @merchant_1 = create(:merchant)
    @merchant_2 = create(:merchant)
    @merchant_3 = create(:merchant)
    @merchant_4 = create(:merchant)
    @merchant_5 = create(:merchant)
  end

  it 'Shows form to update merchant and updates data when Update Merchant is clicked' do
    visit admin_merchant_path(@merchant_1)

    click_on('Edit Merchant')
    expect(current_path).to eq("/admin/merchants/#{@merchant_1.id}/edit")

    fill_in('merchant_name', with: 'Jeremy Spevack')
    click_on('Update Merchant')
    expect(current_path).to eq("/admin/merchants/#{@merchant_1.id}")
    expect(page).to have_content('Jeremy Spevack')
  end
end
