require 'rails_helper'

RSpec.describe '/admin/merchants', type: :feature do
  before(:each) do
    @merchant_1 = Merchant.create!(name: 'Etsy')
    @merchant_2 = Merchant.create!(name: 'Build-a-Bear')
  end

  it 'Shows me the name of he merchant' do
    visit "/admin/merchants/#{@merchant_1.id}"

    expect(page).to have_content(@merchant_1.name)
  end

  it 'I see a link to update the merchants info where im taken to edit this merchant' do
    visit "/admin/merchants/#{@merchant_1.id}"

  
    expect(page).to have_content(@merchant_1.name)

    click_link('Update Merchant')

    expect(current_path).to eq("/admin/merchants/#{@merchant_1.id}/edit")
  end

end  