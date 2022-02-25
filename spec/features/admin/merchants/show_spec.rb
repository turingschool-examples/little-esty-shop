require 'rails_helper'

RSpec.describe "Admin Merchant Show Page" do
  it "displays merchant name " do
    merchant = Merchant.create!(name: 'Chuckin Pucks')
    visit "/admin/merchants/#{merchant.id}"
    expect(page).to have_content(merchant.name)
  end
end
