require 'rails_helper'
FactoryBot.find_definitions

RSpec.describe 'admin merchants index' do
  before :each do
    @merchant_1 = create(:merchant)
    @merchant_2 = create(:merchant)
    @merchant_3 = create(:merchant)
    @merchant_4 = create(:merchant)
    @merchant_5 = create(:merchant)
  end

  it 'lists all merchants' do
    visit admin_merchants_path

     expect(page).to have_content(@merchant_1.name)
     expect(page).to have_content(@merchant_2.name)
     expect(page).to have_content(@merchant_3.name)
     expect(page).to have_content(@merchant_4.name)
     expect(page).to have_content(@merchant_5.name)
  end

  it 'links to a mercant show page' do
    visit admin_merchants_path

    click_link(@merchant_1.name)

    expect(current_path).to eq("/admin/merchants/#{@merchant_1.id}")
  end

  it 'has an interface to enable or disable merchants' do
    @merchant_2.destroy
    @merchant_3.destroy
    @merchant_4.destroy
    @merchant_5.destroy

    visit admin_merchants_path

    within('#disabled_merchants') do
      expect(page).not_to have_button("Disable")

      click_button("Enable")

      expect(page).not_to have_button("Disable")
      expect(page).not_to have_content(@merchant_1.name)
    end

    within('#enabled_merchants') do
      expect(page).to have_button("Disable")

      click_button("Disable")

      expect(page).not_to have_content("Disable")
      expect(page).not_to have_content(@merchant_1.name)
    end

  end
end
