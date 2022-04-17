require 'rails_helper'

RSpec.describe "Admin Merchants Index" do 
    before :each do
      @merchant_1 = Merchant.create!(
      name: "Wally World",
      created_at: Date.current,
      updated_at: Date.current)

      @merchant_2 = Merchant.create!(
      name: "Mako",
      created_at: Date.current,
      updated_at: Date.current)

      @merchant_3 = Merchant.create!(
      name: "Silly Stuff",
      created_at: Date.current,
      updated_at: Date.current)

      @merchant_4 = Merchant.create!(
      name: "The Store",
      created_at: Date.current,
      updated_at: Date.current)
    

        visit '/admin/merchants'
    end

    it 'has a list of merchants'  do 
        expect(page).to have_content("Wally World")
        expect(page).to have_content("The Store")
        expect(page).to_not have_content("Soccerball")
    end

    it "links to each merchants show page" do
        save_and_open_page
        click_on "The Store"
        expect(current_path).to eq("/admin/merchants/#{@merchant_4.id}")
        expect(page).to have_content("The Store")
        expect(page).to_not have_content("Wally World")
    end

end