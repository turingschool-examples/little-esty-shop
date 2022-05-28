require 'rails_helper'

RSpec.describe 'merchant dashboard show' do

  let!(:merchant1) { Merchant.create!(name: "Schroeder-Jerde") }
  let!(:merchant2) { Merchant.create!(name: "Klein, Rempel and Jones") }
  let!(:merchant3) { Merchant.create!(name: "Willms and Sons") }

  it "displays a merchant's name" do
    visit "/merchants/#{merchant1.id}/dashboard"

    \expect(page).to have_content("Schroeder-Jerde")
  end
end
