require 'rails_helper'

RSpec.describe 'Admin Merchants Edit Page' do
  before :each do
    @merchant1 = Merchant.create!(name: 'Tom Holland')


    visit "/admin/merchants/#{@merchant1.id}/edit"
  end

  it 'is on the correct page' do
    expect(current_path).to eq("/admin/merchants/#{@merchant1.id}/edit")
    expect(page).to have_content("Editing Merchant: #{@merchant1.name}")
  end

  it 'can show merchant update form' do
    expect(page).to have_field('Name')
  end

  it 'can edit admin merchant name' do
    fill_in('Name', with: 'Johnny Rocket')

    click_button 'Update Merchant'

    expect(current_path).to eq("/admin/merchants/#{@merchant1.id}")
    expect(page).to have_content("Item successfully updated.")
    expect(page).to have_content("Johnny Rocket")
  end
end
