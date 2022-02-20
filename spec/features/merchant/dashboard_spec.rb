require 'rails_helper' 

RSpec.describe "Merchant Dashboard" do 
   it "displays merchant name" do 
    merchant = Merchant.create!(name: "Schroeder-Jerde")
    merchant2 = Merchant.create!(name: "Klein, Rempel and Jones")
    visit "/merchants/#{merchant.id}/dashboard"
    expect(page).to have_content(merchant.name)
    expect(page).to_not have_content(merchant2.name)
    save_and_open_page
   end 
end 