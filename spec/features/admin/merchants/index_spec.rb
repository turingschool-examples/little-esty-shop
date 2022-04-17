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
      status: "enabled",
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
        click_on "The Store"
        expect(current_path).to eq("/admin/merchants/#{@merchant_4.id}")
        expect(page).to have_content("The Store")
        expect(page).to_not have_content("Wally World")
    end

    it "has a button to enable or disable merchant" do
        save_and_open_page
        within("##{@merchant_1.id}") do 
            expect(page).to have_button("Enable")
        end
        within("##{@merchant_3.id}") do
            expect(page).to have_button("Disable")
        end 
    end

    xit "will change the enabled or disabled status of merchant" do
        within()
    end

end