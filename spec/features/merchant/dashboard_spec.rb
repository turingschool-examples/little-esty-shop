require 'rails_helper'

describe "Merchant Dashboard", type: :feature do
  it 'displays the name of the merchant on the page' do
    merchant = create(:merchant)
    visit "/merchant/#{merchant.id}/dashboard"

    expect(page).to have_content(merchant.name)
  end
end
