require 'rails_helper'

RSpec.describe 'Admin Merchants Show' do

  it 'Displays the name of the merchant' do
    visit admin_merchant_path(Merchant.all.first)

    expect(page).to have_content(Merchant.all.first.name)
    expect(page).to_not have_content(Merchant.all.last.name)
  end

  it 'has a link to update the merchant' do
    visit admin_merchant_path(Merchant.all.first)

    expect(page).to have_link('Edit this merchant', href: edit_admin_merchant_path(Merchant.all.first))
  end
end