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

      describe "Top 5 Merchants by Revenue" do
        before :each do
          @merchant_1 = create(:merchant, name: "Merchant_1")
          @merchant_2 = create(:merchant, name: "Merchant_2")
          @merchant_3 = create(:merchant, name: "Merchant_3")
          @merchant_4 = create(:merchant, name: "Merchant_4")
          @merchant_5 = create(:merchant, name: "Merchant_5")
          @merchant_6 = create(:merchant, name: "Merchant_6")

          @item_1 = create(:item, merchant: @merchant_1)
          @item_2 = create(:item, merchant: @merchant_2)
          @item_3 = create(:item, merchant: @merchant_3)
          @item_4 = create(:item, merchant: @merchant_4)
          @item_5 = create(:item, merchant: @merchant_5)
          @item_6 = create(:item, merchant: @merchant_6)

          @invoice_2 = create(:invoice)
          @invoice_1 = create(:invoice)
          @invoice_3 = create(:invoice)
          @invoice_4 = create(:invoice)

          @invoice_items_1 = create(:invoice_items, invoice: @invoice_1, item: @item_1, unit_price: 600, quantity: 1) #600 - fails
          @invoice_items_2 = create(:invoice_items, invoice: @invoice_2, item: @item_2, unit_price: 400, quantity: 1) #400
          @invoice_items_3 = create(:invoice_items, invoice: @invoice_2, item: @item_3, unit_price: 400, quantity: 2) #800
          @invoice_items_4 = create(:invoice_items, invoice: @invoice_3, item: @item_4, unit_price: 300, quantity: 4) #1200
          @invoice_items_5 = create(:invoice_items, invoice: @invoice_3, item: @item_5, unit_price: 200, quantity: 10) #2000
          @invoice_items_6 = create(:invoice_items, invoice: @invoice_4, item: @item_6, unit_price: 100, quantity: 5) #500

          @transaction_1 = create(:transaction, invoice: @invoice_1, result: :failed)
          @transaction_2 = create(:transaction, invoice: @invoice_1, result: :failed)
          @transaction_3 = create(:transaction, invoice: @invoice_2, result: :success)
          @transaction_4 = create(:transaction, invoice: @invoice_2, result: :success)
          @transaction_5 = create(:transaction, invoice: @invoice_3, result: :failed)
          @transaction_6 = create(:transaction, invoice: @invoice_3, result: :success)
          @transaction_7 = create(:transaction, invoice: @invoice_4, result: :success)
          @transaction_8 = create(:transaction, invoice: @invoice_4, result: :success)
        end
        
        it 'I see the names of the top 5 merchants by total revenue generated' do
          visit admin_merchants_path
          
          within("#top-5-merchants") do
            expect(@merchant_5.name).to appear_before(@merchant_2.name)
            expect(@merchant_5.name).to appear_before(@merchant_3.name)
            expect(@merchant_5.name).to appear_before(@merchant_4.name)
            expect(@merchant_5.name).to appear_before(@merchant_6.name)

            expect(@merchant_3.name).to appear_before(@merchant_4.name)
            expect(@merchant_3.name).to appear_before(@merchant_6.name)
            expect(@merchant_3.name).to appear_before(@merchant_2.name)

            expect(@merchant_4.name).to appear_before(@merchant_6.name)
            expect(@merchant_4.name).to appear_before(@merchant_2.name)

            expect(@merchant_6.name).to appear_before(@merchant_2.name)

            expect(page).to_not have_content(@merchant_1.name)
          end
        end

        it 'I see that each merchant name links to the admin merchant show page for that merchant' do
          visit admin_merchants_path

          within("#top-5-merchants") do
            within("#merchant-#{@merchant_5.id}") do
              click_link "#{@merchant_5.name}"
              expect(current_path).to eq(admin_merchant_path(@merchant_5))
            end
            visit admin_merchants_path
            within("#merchant-#{@merchant_2.id}") do
              click_link "#{@merchant_2.name}"
              expect(current_path).to eq(admin_merchant_path(@merchant_2))
            end
          end
        end
        
        it 'I see the total revenue generated next to each merchant name' do
          visit admin_merchants_path

          within("#top-5-merchants") do
            within("#merchant-#{@merchant_5.id}") do
              expect(page).to have_content((@merchant_5.items.total_revenue_of_all_items/100))
              expect(page).to_not have_content((@merchant_4.items.total_revenue_of_all_items/100))
            end
            visit admin_merchants_path
            within("#merchant-#{@merchant_2.id}") do
              expect(page).to have_content((@merchant_2.items.total_revenue_of_all_items/100))
              expect(page).to_not have_content((@merchant_3.items.total_revenue_of_all_items/100))
            end
          end
        end

        it 'Then next to each of the 5 merchants by revenue I see the date with the most revenue for each merchant with the label “Top selling date for was ".' do
          visit admin_merchants_path
          within("#top-5-merchants") do
            within("#merchant-#{@merchant_5.id}") do
              expect(page).to have_content("Top selling date for #{@merchant_5.name} was #{@merchant_5.invoices.best_day.created_at.strftime("%A, %B %d, %Y")}")
              expect(page).to_not have_content("Top selling date for #{@merchant_6.name} was #{@merchant_6.invoices.best_day.created_at.strftime("%A, %B %d, %Y")}")
            end
            visit admin_merchants_path
            within("#merchant-#{@merchant_2.id}") do
              expect(page).to have_content("Top selling date for #{@merchant_2.name} was #{@merchant_2.invoices.best_day.created_at.strftime("%A, %B %d, %Y")}")
              expect(page).to_not have_content("Top selling date for #{@merchant_6.name} was #{@merchant_6.invoices.best_day.created_at.strftime("%A, %B %d, %Y")}")
            end
          end
        end

      end
    end
  end
end