require 'rails_helper'

RSpec.describe "the merchant's dashboard page" do
  it "shows the merchant's name" do
    crystal_moon = Merchant.create!(name: "Crystal Moon Designs")

    visit "/merchants/#{crystal_moon.id}/dashboard"

    expect(page).to have_content("Crystal Moon Designs")
  end
end