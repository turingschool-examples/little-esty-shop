require 'rails_helper'

RSpec.describe "Admin Merchants" do
    describe "As an admin" do
        describe "I visit the admin merchants index (/admin/merchants)" do
            before :each do
                @merchant_1 = Merchant.create!(name: "Johns Tools")
                @merchant_2 = Merchant.create!(name: "Hannas Hammocks")
                @merchant_3 = Merchant.create!(name: "Pretty Plumbing")
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


        end
    end
end