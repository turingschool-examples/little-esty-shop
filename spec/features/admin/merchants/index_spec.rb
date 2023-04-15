require 'rails_helper'

RSpec.describe '/admin/merchants', type: :feature do
  before(:each) do
    @merchant_1 = Merchant.create!(name: 'Etsy')
    @merchant_2 = Merchant.create!(name: 'Build-a-Bear')
  end

  it 'I see the name of each merchant in the system' do
    visit "/admin/merchants"

    expect(page).to have_content(@merchant_1.name)
    expect(page).to have_content(@merchant_2.name)    
  end

  it 'I can click on the name of the merchant' do
    visit "/admin/merchants"
    save_and_open_page

    expect(page).to have_link(@merchant_1.name, href: "admin/merchants/#{@merchant_1.id}/")
  end

end

