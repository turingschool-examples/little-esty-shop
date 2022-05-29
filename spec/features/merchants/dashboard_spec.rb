require 'rails_helper'

RSpec.describe "merchant dashboard", type: :feature do
  before :each do
    @merchant_1 = Merchant.create(name: "Schroeder-Jerde" )
    @merchant_2 = Merchant.create(name: "Klein, Rempel and Jones")
  end
  it "shows name of merchant" do
    visit "/merchants/#{@merchant_1.id}/dashboard"

    expect(page).to have_content("Schroeder-Jerde")
    expect(page).to_not have_content("Klein, Rempel and Jones")
  end

end
