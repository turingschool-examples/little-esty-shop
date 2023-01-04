require 'rails_helper'

RSpec.describe 'Admin Merchants index' do

  it 'Displays the name of each merchant' do
    visit admin_merchants_path

    expect(page).to have_content(Merchant.all.first.name)
    expect(page).to have_content(Merchant.all.fifth.name)
    expect(page).to have_content(Merchant.all.last.name)
  end

  it 'Has links to each merchant show page' do
    visit admin_merchants_path

    click_on(Merchant.all.first.name)

    expect(page).to have_content(Merchant.all.first.name)
    expect(page).to_not have_content(Merchant.all.last.name)
    expect(current_path).to eq("/admin/merchants/#{Merchant.all.first.id}")
  end
end