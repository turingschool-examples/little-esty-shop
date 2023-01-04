require 'rails_helper'

RSpec.describe 'Admin Merchants index' do

  it 'Displays the name of each merchant' do
    visit admin_merchants_path

    expect(page).to have_content(Merchant.all.first.name)
    expect(page).to have_content(Merchant.all.fifth.name)
    expect(page).to have_content(Merchant.all.last.name)
  end
end