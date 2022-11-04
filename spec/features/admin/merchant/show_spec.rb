require "rails_helper"

RSpec.describe "admin/merchants-show page" do
    before :each do
    @merchant_1 = Merchant.create!(name: "Marvel")
    @merchant_2 = Merchant.create!(name: "D.C.")
    @merchant_3 = Merchant.create!(name: "Darkhorse")
    @merchant_4 = Merchant.create!(name: "Image")
    
    visit "/admin/merchants/#{@merchant_1.id}"
  end
# US 26 As an admin,
# When I visit a merchant's admin show page
# Then I see a link to update the merchant's information.
# When I click the link
# Then I am taken to a page to edit this merchant
# And I see a form filled in with the existing merchant attribute information
# When I update the information in the form and I click ‘submit’
# Then I am redirected back to the merchant's admin show page where I see the updated information
# And I see a flash message stating that the information has been successfully updated.
    describe 'on the merchants admin show page I see a link and am taken to a page to edit this merchant' do 
      it "has a link to update merchant's info" do
       click_link "Update Merchant"
       expect(current_path).to eq("/admin/merchants/#{@merchant_1.id}")
    
      end
    end
      it "When the user updates the information in the form and click submit" do 
        visit "/admin/merchants/#{@merchant_1.id}"
        expect(page).to have_link("Update Merchant")
        click_link "Update Merchant"
        expect(current_path).to eq("/admin/merchants/#{@merchant_1.id}")
        

        visit "/admin/merchants/#{@merchant_1.id}/edit" 
        expect(page).to have_content("Marvel")
        fill_in "name", with: "Ms. Marvel"
        click_button("Submit")
        expect(current_path).to eq("/admin/merchants/#{@merchant_1.id}")
        expect(page).to have_content("Successfully Updated: Ms Marvel")
        expect(page).to have_content("MS. Marvel")
      end


end
