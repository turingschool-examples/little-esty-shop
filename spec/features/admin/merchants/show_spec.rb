require 'rails_helper'

RSpec.describe 'admin merchants show page', type: :feature do
  before(:each) do
    @merchant_1 = create(:merchant) #Sprouts
    @merchant_2 = create(:merchant, name: "Jennys Jewels")
    @merchant_3 = create(:merchant, name: "Strawberry Prints")
  end

  it 'displays correct merchant name' do
    visit "/admin/merchants/#{@merchant_1.id}"

    expect(page).to have_content(@merchant_1.name)
    expect(page).to_not have_content(@merchant_2.name)
    expect(page).to_not have_content(@merchant_3.name)
  end

  it 'has update link' do
    visit "/admin/merchants/#{@merchant_1.id}"

    expect(page).to have_link("Edit #{@merchant_1.name}")
    expect(page).to_not have_link("Edit #{@merchant_2.name}")
    expect(page).to_not have_link("Edit #{@merchant_3.name}")

    click_on "Edit #{@merchant_1.name}"
    expect(current_path).to eq("/admin/merchants/#{@merchant_1.id}/edit")
  end
end
