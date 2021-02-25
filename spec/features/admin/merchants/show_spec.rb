require 'rails_helper'
describe 'Admin Merchant Show Page' do
  before :each do
    @merchant = create(:merchant)
  end

  it 'sees name of merchant' do
    visit '/admin/merchants'

    click_link "#{@merchant.name}"
    expect(current_path).to eq("/admin/merchants/#{@merchant.id}")

    expect(page).to have_content(@merchant.name)
  end

  it 'has link to update merchant' do
    visit "/admin/merchants/#{@merchant.id}"

    click_link "Update"
    expect(current_path).to eq("/admin/mechants/#{@merchant.id}/edit")
  end
end
