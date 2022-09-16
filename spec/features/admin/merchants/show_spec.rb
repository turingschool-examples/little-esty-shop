require 'rails_helper'

RSpec.describe "Admin Show" do
  describe "As an admin" do
    before :each do
        @merchant_1 = Merchant.create!(name: "Johns Tools")
        @merchant_2 = Merchant.create!(name: "Hannas Hammocks")
    end

    it 'us#25 - I see the name of that merchant' do
        visit admin_merchant_path(@merchant_1)
        expect(page).to have_content(@merchant_1.name)
    end

    describe "I visit a merchant's admin show page" do
      
      it "I see a link to update the merchant's information" do
        visit admin_merchant_path(@merchant_1)

        expect(page).to have_link("Update")
      end

      it "When I click the link, I am taken to a page to edit this merchant"
      
      it "I see a form filled in with the existing merchant attribute information"

      it "When I update the information in the form and I click ‘submit’, I am redirected back to the merchant's admin show page where I see the updated information and I see a flash message stating that the information has been successfully updated"

    end
  end
end