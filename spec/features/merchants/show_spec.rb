require 'rails_helper'

RSpec.describe 'Merchant Show Dash' do
  it "has the name of the merchant on the page" do
    billman = Merchant.create!(name: "Billman")

    visit "/merchants/#{billman.id}/dashboard"

    expect(page).to have_content(billman.name)
  end
end
