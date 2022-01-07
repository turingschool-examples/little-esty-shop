require 'rails_helper'

RSpec.describe 'Admin show page' do

  let!(:merchant_1) {Merchant.create!(name: 'Billys Pet Rocks')}
  let!(:merchant_2) {Merchant.create!(name: 'Merchant 2')}

  it 'show page is accessible with link from index page' do
    visit '/admin/merchants'
    click_link("#{merchant_1.name}")
  end

  it 'shows name for one merchant' do
    visit "/admin/merchants/#{merchant_1.id}"
    expect(page).to have_content("#{merchant_1.name}")
    expect(page).to_not have_content("#{merchant_2.name}")
  end

end
