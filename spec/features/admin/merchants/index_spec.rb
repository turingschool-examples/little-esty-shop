require 'rails_helper'

RSpec.describe "Admin Merchants" do
  describe "As an admin" do
    describe "I visit the admin merchants index (/admin/merchants)" do
      before :each do
        @merchant_1 = Merchant.create!(name: "Johns Tools")
        @merchant_2 = Merchant.create!(name: "Hannas Hammocks")
        @merchant_3 = Merchant.create!(name: "Pretty Plumbing" active_status:"disabled")
        @merchant_4 = Merchant.create!(name: "Jenna's Jewlery")
        @merchant_5 = Merchant.create!(name: "Sassy Soap", active_status:"disabled")
      end
  
      it 'can see the name of each merchant in the system' do
        visit admin_merchants_path
        expect(page).to have_content(@merchant_1.name)
        expect(page).to have_content(@merchant_2.name)
        expect(page).to have_content(@merchant_3.name)
      end

      it "us#25 When I click on the name of a merchant then I am taken to that merchant's admin show page (/admin/merchants/merchant_id)" do
        visit admin_merchants_path

        click_link "#{@merchant_1.name}"

        expect(current_path).to eq(admin_merchant_path(@merchant_1.id))
      end

      it "Next to each merchant name I see a button to disable or enable that merchant." do
        visit admin_merchants_path

        within("#merchant-#{@merchant_1.id}") do
          expect(page).to have_button("Disable")
        end
        within("#merchant-#{@merchant_2.id}") do
          expect(page).to have_button("Disable")
        end
        within("#merchant-#{@merchant_3.id}") do
          expect(page).to have_button("Enable")
        end
      
      end

      it "When I click this button, I am redirected back to the admin merchants index" do

      end

      it "I see that the merchant's status has changed" do

      end

    end
  end
end