require 'rails_helper'

RSpec.describe 'Admin Merchant Show Page' do
  let!(:merchant_1) {Merchant.create!(name: 'Ron Swanson')}
  let!(:merchant_2) {Merchant.create!(name: 'Leslie Knope')}

  before(:each) do
    visit admin_merchant_path(merchant_1.id)
  end

  scenario 'visitor clicks on name of merchant from the index page and now is on that merchants show page' do
    visit admin_merchants_path
    click_link("#{merchant_1.name}")

    expect(current_path).to eq(admin_merchant_path(merchant_1.id))
  end

  scenario 'visitor sees that merchant name' do
    expect(page).to have_content(merchant_1.name)
    expect(page).to_not have_content(merchant_2.name)
  end

  scenario 'visitor sees link to update merchant information' do
     expect(page).to have_link("Update Merchant")
  end

  scenario 'visitor clicks link and is directed to edit page that has a form with the exisiting attribute info' do
     click_link("Update Merchant")

     expect(current_path).to eq(edit_admin_merchant_path(merchant_1.id))
  end

  scenario 'visitor updates information, clicks submit, and is redirected back to merchant page with updated information and a successful flash message' do
    visit edit_admin_merchant_path(merchant_1.id)
    fill_in('Name', with: 'Ronny Wrongson')
    click_button('Update Merchant')

    expect(current_path).to eq(admin_merchant_path(merchant_1.id))
    expect(page).to have_content('Ronny Wrongson')
    expect(page).to have_content("Successfully Updated Merchant Information")
  end
end
