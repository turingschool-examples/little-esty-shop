require 'rails_helper'

RSpec.describe "Admin Merchant Index" do
    before :each do
        @merch1 = Merchant.create!(name: 'Floopy Fopperations', status: 1)
        @merch2 = Merchant.create!(name: 'A-Team', status: 1)
        @merch3 = Merchant.create!(name: 'Blue Clues', status: 0)
        @merch4 = Merchant.create!(name: 'Apple Bottom Jeans', status: 0)
    end

    describe "Admin Merchant Index" do
        it "displays the name of all merchants in the system" do
            visit "/admin/merchants"
            expect(page).to have_content("Floopy Fopperations")
            expect(page).to have_content("A-Team")
            expect(page).to have_content("Blue Clues")
            expect(page).to have_content("Apple Bottom Jeans")
        end

        it 'displays the top 5 merchants by revenue' do

            @merch5 = Merchant.create!(name: 'Rawnald')
            @merch6 = Merchant.create!(name: 'Zombies R Us')
            @merch7 = Merchant.create!(name: 'We are Coffee')
            @merch8 = Merchant.create!(name: 'Hannah French Montanna')
            @customer1 = Customer.create!(first_name: 'Joe', last_name: 'Bob')
            @item1 = @merch1.items.create!(name: 'Floopy Original', description: 'the best', unit_price: 450)
            @item2 = @merch2.items.create!(name: 'A-Team Original', description: 'the better', unit_price: 950)
            @item3 = @merch3.items.create!(name: 'Blue Retro', description: 'the OG', unit_price: 550)
            @item4 = @merch4.items.create!(name: 'Apple', description: 'the OG', unit_price: 550)
            @item5 = @merch5.items.create!(name: 'The Rawnald', description: 'the best', unit_price: 450)
            @item6 = @merch6.items.create!(name: 'The Zombie', description: 'the better', unit_price: 950)
            @item7 = @merch7.items.create!(name: 'The Coffee', description: 'the OG', unit_price: 550)
            @item8 = @merch8.items.create!(name: 'The Hannah', description: 'the OG', unit_price: 550)
            @item9 = @merch1.items.create!(name: 'Floopy Updated', description: 'the better', unit_price: 1450)
            @invoice1 = @customer1.invoices.create!(status: 2, updated_at: Time.parse("2012-03-30 14:54:09 UTC"))
            @invoice1.transactions.create!(result: 0)
            @invoice2 = @customer1.invoices.create!(status: 2)
            @invoice2.transactions.create!(result: 0)
            @invoice3 = @customer1.invoices.create!(status: 2)
            @invoice3.transactions.create!(result: 1)
            InvoiceItem.create!(item_id: @item1.id, invoice_id: @invoice1.id, quantity: 1, unit_price: 10000, status: 0)
            InvoiceItem.create!(item_id: @item2.id, invoice_id: @invoice2.id, quantity: 2, unit_price: 10000, status: 1)
            InvoiceItem.create!(item_id: @item3.id, invoice_id: @invoice1.id, quantity: 3, unit_price: 10000, status: 1)
            InvoiceItem.create!(item_id: @item4.id, invoice_id: @invoice2.id, quantity: 4, unit_price: 10000, status: 2)
            InvoiceItem.create!(item_id: @item5.id, invoice_id: @invoice1.id, quantity: 5, unit_price: 10000, status: 0)
            InvoiceItem.create!(item_id: @item6.id, invoice_id: @invoice2.id, quantity: 6, unit_price: 10000, status: 2)
            InvoiceItem.create!(item_id: @item7.id, invoice_id: @invoice1.id, quantity: 1, unit_price: 500, status: 2)
            InvoiceItem.create!(item_id: @item8.id, invoice_id: @invoice3.id, quantity: 1000, unit_price: 10000, status: 2)
            InvoiceItem.create!(item_id: @item9.id, invoice_id: @invoice1.id, quantity: 10, unit_price: 20000, status: 2)

            visit "/admin/merchants"

            #making the assumption that the only "check" we are doing is if the transaction wsa successful to count towards revenue (invoice item status does not matter)

            expect(page).to have_content("Top 5 Merchants by Total Revenue Generated:")
            within "#top-5-merchants" do
              expect(page).to have_link(@merch1.name)
              expect(page).to have_content(210000)
              expect(page).to have_link(@merch6.name)
              expect(page).to have_content(60000)
              expect(page).to have_link(@merch5.name)
              expect(page).to have_content(50000)
              expect(page).to have_link(@merch4.name)
              expect(page).to have_content(40000)
              expect(page).to have_link(@merch3.name)
              expect(page).to have_content(30000)

              click_link(@merch1.name)
            end

            expect(current_path).to eq("/admin/merchants/#{@merch1.id}")
            expect(page).to have_content(@merch1.name)
            expect(page).to_not have_content(@merch2.name)
        end

        it 'can create a new merchant and show its status' do

          visit "/admin/merchants"
          click_link "Create a New Merchant"

          expect(current_path).to eq("/admin/merchants/new")

          fill_in "Name", with: "Zachary's Coffee Grounds"
          click_on "Submit"

          expect(current_path).to eq("/admin/merchants")
          expect(page).to have_content("Zachary's Coffee Grounds")
          expect(page).to have_content("disabled")
        end


        it 'shows the enabled and disabled merchants' do
          visit "/admin/merchants"

          expect(page).to have_content("Enabled Merchants:")
          expect(page).to have_content("Disabled Merchants:")
          within "#enabled-merchants" do
            expect(page).to have_content('Floopy Fopperations')
            expect(page).to have_content('A-Team')
          end
          within "#disabled-merchants" do
            expect(page).to have_content('Blue Clues')
            expect(page).to have_content('Apple Bottom Jeans')
          end
        end

        it "has a button to enable/diable mechant next to each name" do
            visit "/admin/merchants"
            within "#merchant-#{@merch1.id}" do
                expect(page).to have_content("Floopy Fopperations")
                expect(page).to have_content("Status: enabled")
                expect(page).to_not have_content("Status: disabled")
                click_button "Disable"
                expect(current_path).to eq("/admin/merchants")
                expect(page).to have_content("Status: disabled")
                expect(page).to_not have_content("Status: enabled")
            end

            within "#merchant-#{@merch2.id}" do
                expect(page).to have_content("A-Team")
                expect(page).to have_content("Status: enabled")
                expect(page).to_not have_content("Status: disabled")
                click_button "Disable"
                expect(current_path).to eq("/admin/merchants")
                expect(page).to have_content("Status: disabled")
                expect(page).to_not have_content("Status: enabled")
                click_button "Enable"
                expect(current_path).to eq("/admin/merchants")
                expect(page).to have_content("Status: enabled")
                expect(page).to_not have_content("Status: disabled")
            end
        end

        it 'shows the date with the most revenue next to each of the top 5 merchants' do
          @merch5 = Merchant.create!(name: 'Rawnald')
          @merch6 = Merchant.create!(name: 'Zombies R Us')
          @merch7 = Merchant.create!(name: 'We are Coffee')
          @merch8 = Merchant.create!(name: 'Hannah French Montanna')
          @customer1 = Customer.create!(first_name: 'Joe', last_name: 'Bob')
          @item1 = @merch1.items.create!(name: 'Floopy Original', description: 'the best', unit_price: 450)
          @item2 = @merch2.items.create!(name: 'A-Team Original', description: 'the better', unit_price: 950)
          @item3 = @merch3.items.create!(name: 'Blue Retro', description: 'the OG', unit_price: 550)
          @item4 = @merch4.items.create!(name: 'Apple', description: 'the OG', unit_price: 550)
          @item5 = @merch5.items.create!(name: 'The Rawnald', description: 'the best', unit_price: 450)
          @item6 = @merch6.items.create!(name: 'The Zombie', description: 'the better', unit_price: 950)
          @item7 = @merch7.items.create!(name: 'The Coffee', description: 'the OG', unit_price: 550)
          @item8 = @merch8.items.create!(name: 'The Hannah', description: 'the OG', unit_price: 550)
          @item9 = @merch1.items.create!(name: 'Floopy Updated', description: 'the better', unit_price: 1450)
          @invoice1 = @customer1.invoices.create!(status: 2, updated_at: Time.parse("2012-03-30 14:54:09 UTC"))
          @invoice1.transactions.create!(result: 0)
          @invoice2 = @customer1.invoices.create!(status: 2, updated_at: Time.parse("2012-04-30 14:54:09 UTC"))
          @invoice2.transactions.create!(result: 0)
          @invoice3 = @customer1.invoices.create!(status: 2, updated_at: Time.parse("2012-06-30 14:54:09 UTC"))
          @invoice3.transactions.create!(result: 1)
          InvoiceItem.create!(item_id: @item1.id, invoice_id: @invoice1.id, quantity: 1, unit_price: 10000, status: 0)
          InvoiceItem.create!(item_id: @item2.id, invoice_id: @invoice2.id, quantity: 2, unit_price: 10000, status: 1)
          InvoiceItem.create!(item_id: @item3.id, invoice_id: @invoice1.id, quantity: 3, unit_price: 10000, status: 1)
          InvoiceItem.create!(item_id: @item4.id, invoice_id: @invoice2.id, quantity: 4, unit_price: 10000, status: 2)
          InvoiceItem.create!(item_id: @item5.id, invoice_id: @invoice1.id, quantity: 5, unit_price: 10000, status: 0)
          InvoiceItem.create!(item_id: @item6.id, invoice_id: @invoice2.id, quantity: 6, unit_price: 10000, status: 2)
          InvoiceItem.create!(item_id: @item7.id, invoice_id: @invoice1.id, quantity: 1, unit_price: 500, status: 2)
          InvoiceItem.create!(item_id: @item8.id, invoice_id: @invoice3.id, quantity: 1000, unit_price: 10000, status: 2)
          InvoiceItem.create!(item_id: @item9.id, invoice_id: @invoice1.id, quantity: 10, unit_price: 20000, status: 2)
          # As an admin,
          # When I visit the admin merchants index
          # Then next to each of the 5 merchants by revenue I see the date with the most revenue for each merchant.
          # And I see a label “Top selling date for was "
          #
          # Note: use the invoice date. If there are multiple days with equal number of sales, return the most recent day.

          visit "/admin/merchants"

          expect(page).to have_content("Top selling date for us was:")
          expect(page).to have_content("March 30, 2012")
        end
    end

end
