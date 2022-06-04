require 'rails_helper'

RSpec.describe "Admin Merchant Index" do
    before :each do
        @merch1 = Merchant.create!(name: 'Floopy Fopperations')
        @merch2 = Merchant.create!(name: 'A-Team')
        @merch3 = Merchant.create!(name: 'Blue Clues')
        @merch4 = Merchant.create!(name: 'Apple Bottom Jeans')
    end

    describe "Admin Merchant Index" do
        xit "displays the name of all merchants in the system" do
            visit "/admin/merchants"
            expect(page).to have_content("Floopy Fopperations")
            expect(page).to have_content("A-Team")
            expect(page).to have_content("Blue Clues")
            expect(page).to have_content("Apple Bottom Jeans")
        end

        it 'displays the top 5 merchants by revenue' do
            # As an admin,
            # When I visit the admin merchants index
            # Then I see the names of the top 5 merchants by total revenue generated
            # And I see that each merchant name links to the admin merchant show page for that merchant
            # And I see the total revenue generated next to each merchant name
            #
            # Notes on Revenue Calculation:
            #
            # Only invoices with at least one successful transaction should count towards revenue
            # Revenue for an invoice should be calculated as the sum of the revenue of all invoice items
            # Revenue for an invoice item should be calculated as the invoice item unit price multiplied by the quantity (do not use the item unit price)
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
            # @merch1.total_revenue
            # @merch8.total_revenue
            # binding.pry
            visit "/admin/merchants"
            # x = Merchant.top_five_merchants_by_revenue
            # save_and_open_page
            # binding.pry
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
            # binding.pry
            # save_and_open_page
            expect(page).to have_content(@merch1.name)
            expect(page).to_not have_content(@merch2.name)
        end
    end

end
