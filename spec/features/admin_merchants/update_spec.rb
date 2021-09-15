require 'rails_helper'

describe 'Admin Merchants Update' do
  before :each do
    @merchant1 = Merchant.create!(name: 'Steve Momoa', created_at: "2012-03-27 14:54:09", updated_at: "2012-03-27 14:54:09")
    @merchant2 = Merchant.create!(name: 'The Rock', created_at: "2012-03-27 14:54:09", updated_at: "2012-03-27 14:54:09")
  end

  it 'lists names of all Merchants' do
    visit "/admin/merchants/#{@merchant1.id}"

    click_link 'Update'

    expect(current_path).to eq("/admin/merchants/#{@merchant1.id}/edit")
    save_and_open_page
    fill_in 'Name', with: "Jason Momoa"
    click_button 'Submit'

    expect(current_path).to eq("/admin/merchants/#{@merchant1.id}")
    expect(page).to have_content('Jason Momoa')
  end
end
