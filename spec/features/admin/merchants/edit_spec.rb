require 'rails_helper'
describe 'admin merchants edit page' do
  it 'I see a form with the existing attributes filled in' do
    merchant_1 = Merchant.create!(name: 'merchant_1')
    visit "/admin/merchants/#{merchant_1.id}/edit"
    expect(page).to have_content("Name")
    expect(page).to have_content(merchant_1.name)
  end

  it 'when I update the information and click submit I am taken back to show and see the updated info' do
    merchant_1 = Merchant.create!(name: 'merchant_1')
    visit "/admin/merchants/#{merchant_1.id}/edit"

    fill_in("Name", with: "Spencer")
    click_button("Submit")
    expect(current_path).to eq("/admin/merchants/#{merchant_1.id}")
    expect(page).to have_content("Name: Spencer")
    expect(:alert).to be_present
  end
end
