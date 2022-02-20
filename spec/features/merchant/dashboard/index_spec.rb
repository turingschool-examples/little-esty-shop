require 'rails_helper'

RSpec.describe "Merchant Dashboard" do
   it "displays merchant name" do
    merchant = Merchant.create!(name: "Schroeder-Jerde")
    merchant2 = Merchant.create!(name: "Klein, Rempel and Jones")
    visit "/merchant/#{merchant.id}/dashboard"
    expect(page).to have_content(merchant.name)
    expect(page).to_not have_content(merchant2.name)
   end

   it "displays link to merchant items and invoices" do
    merchant = Merchant.create!(name: "Schroeder-Jerde")
    visit "/merchant/#{merchant.id}/dashboard"
    expect(page).to have_link("Items")
    expect(page).to have_link("Invoices")
   end

end
