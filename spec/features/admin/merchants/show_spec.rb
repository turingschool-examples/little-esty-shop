require 'rails_helper'

RSpec.describe 'Admin Merchant Show' do
  it 'shows the merchant name on the page' do
    merchant = Merchant.first
    visit "/admin/merchants/#{merchant.id}"

    expect(page).to have_content(merchant.name)
  end
end