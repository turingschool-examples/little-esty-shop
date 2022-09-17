require 'rails_helper'

RSpec.describe "Admin Merchants" do
  describe "As an admin" do
    describe "I visit the admin merchants index (/admin/merchants)" do
      before :each do
        @merchant_1 = Merchant.create!(name: "Johns Tools")
        @merchant_2 = Merchant.create!(name: "Hannas Hammocks")
        @merchant_3 = Merchant.create!(name: "Pretty Plumbing", active_status: :disabled)
        @merchant_4 = Merchant.create!(name: "Jenna's Jewlery")
        @merchant_5 = Merchant.create!(name: "Sassy Soap", active_status: :disabled)
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
        visit admin_merchants_path
        
        within("#merchant-#{@merchant_1.id}") do
          click_button "Disable"
        end

        expect(current_path).to eq(admin_merchants_path)
      end

      it "I see that the merchant's status has changed" do
        visit admin_merchants_path

        within("#merchant-#{@merchant_2.id}") do
          expect(page).to have_button("Disable")
        end
        
        within("#merchant-#{@merchant_1.id}") do
          expect(page).to have_button("Disable")
          click_button "Disable"
          expect(page).to have_button("Enable")
        end

        within("#merchant-#{@merchant_2.id}") do
          expect(page).to_not have_button("Enable")
        end
      end

      it "I see two sections, one for 'Enabled Merchants' and one for 'Disabled Merchants'" do
        visit admin_merchants_path

        within("#enabled-merchants") do
          expect(page).to have_content("Enabled Merchants")
        end

        within("#disabled-merchants") do
          expect(page).to have_content("Disabled Merchants")
        end
      end

      it "I see that each Merchant is listed in the appropriate section" do
        visit admin_merchants_path

        within("#enabled-merchants") do
          within("#merchant-#{@merchant_1.id}") do
            expect(page).to have_content("#{@merchant_1.name}")
            expect(page).to have_button("Disable")
          end

          within("#merchant-#{@merchant_2.id}") do
            expect(page).to have_content("#{@merchant_2.name}")
            expect(page).to have_button("Disable")
          end
        end

        within("#disabled-merchants") do
          within("#merchant-#{@merchant_3.id}") do
            expect(page).to have_content("#{@merchant_3.name}")
            expect(page).to have_button("Enable")
          end

          within("#merchant-#{@merchant_5.id}") do
            expect(page).to have_content("#{@merchant_5.name}")
            expect(page).to have_button("Enable")
          end
        end
      end

#       Admin Merchant Create

# As an admin,
# When I visit the admin merchants index
# I see a link to create a new merchant.
# When I click on the link,
# I am taken to a form that allows me to add merchant information.
# When I fill out the form I click ‘Submit’
# Then I am taken back to the admin merchants index page
# And I see the merchant I just created displayed
# And I see my merchant was created with a default status of disabled.

      it 'US#29 - Admin Merchant Create' do
        visit admin_merchants_path

      end
      
    end
  end
end