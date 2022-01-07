require 'rails_helper'

RSpec.describe 'Admin index page' do

  let!(:merchant_1) {Merchant.create!(name: 'Billys Pet Rocks')}
  let!(:merchant_2) {Merchant.create!(name: 'Merchant 2')}
  let!(:merchant_3) {Merchant.create!(name: 'Merchant 3')}
  let!(:merchant_4) {Merchant.create!(name: 'Merchant 4')}
  let!(:merchant_5) {Merchant.create!(name: 'Merchant 5')}


  it 'has the name of each merchant in the system' do
    visit '/admin/merchants'
    expect(page).to have_link("#{merchant_1.name}")
    expect(page).to have_link("#{merchant_2.name}")
    expect(page).to have_link("#{merchant_3.name}")
    expect(page).to have_link("#{merchant_4.name}")
    expect(page).to have_link("#{merchant_5.name}")
  end



end
