require 'rails_helper'

RSpec.describe "Admin Merchants" do
  describe "As an admin" do
    describe "I visit the admin merchants index (/admin/merchants)" do
      before :each do
        @merchant_1 = create(:merchant, active_status: :enabled)
        @merchant_2 = create(:merchant, active_status: :enabled)
        @merchant_3 = create(:merchant)
        @merchant_4 = create(:merchant, active_status: :enabled)
        @merchant_5 = create(:merchant)
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

    # Admin Merchants: Top 5 Merchants by Revenue

    # As an admin,
    # When I visit the admin merchants index
    # Then I see the names of the top 5 merchants by total revenue generated
    # And I see that each merchant name links to the admin merchant show page for that merchant
    # And I see the total revenue generated next to each merchant name

    # Notes on Revenue Calculation:

    # Only invoices with at least one successful transaction should count towards revenue -- #if successfull == counts *(.any?)
    # Revenue for an invoice should be calculated as the sum of the revenue of all invoice items -- invoice items.sum
    # Revenue for an invoice item should be calculated as the invoice item unit price multiplied by the quantity (do not use the item unit price) -- invoice item unit price * quantity 

        # @merchant_1 = create(:merchant, active_status: :enabled)
        # @merchant_2 = create(:merchant, active_status: :enabled)
        # @merchant_3 = create(:merchant)
        # @merchant_4 = create(:merchant, active_status: :enabled)
        # @merchant_5 = create(:merchant)

      it 'shows the names of the top 5 merchants by total revenue generated and shows the revenue' do
        visit admin_merchants_path
        #orderly based off of top revenue
        expect(page).to have_content(@merchant_1, @merchant_2, @merchant_3, @merchant_4, @merchant_5) #top5merchants - might have to test individually - and need to organize by top revenue
      end

      it 'I see that each merchant name links to the admin merchant show page for that merchant' do
        visit admin_merchants_path

        click_button "#{@merchant_1.name}"
        expect(current_path).to eq(admin_merchant_path(@merchant_1))
      end
      
      it 'shows the revenue generated by each merchant' do
        visit admin_merchants_path
        #use within blocks to find on page
      end
    end
  end
end