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

          @items_1 = create_list(:item, 10, merchant: @merchant_1)
          @items_2 = create_list(:item, 10, merchant: @merchant_2)
          @items_3 = create_list(:item, 10, merchant: @merchant_3)
          @items_4 = create_list(:item, 10, merchant: @merchant_4)
          @items_5 = create_list(:item, 10, merchant: @merchant_5)
          @items_6 = create_list(:item, 10, merchant: @merchant_6)

          @invoice_2 = create(:invoice)
          @invoice_1 = create(:invoice)
          @invoice_3 = create(:invoice)
          @invoice_4 = create(:invoice)

          @items_1.each { |item| create(:invoice_items, invoice: @invoice_1, item: item, unit_price: 500, quantity: 20) } #10000
          @items_2.each { |item| create(:invoice_items, invoice: @invoice_2, item: item, unit_price: 100, quantity: 5) } #500
          @items_3.each { |item| create(:invoice_items, invoice: @invoice_2, item: item, unit_price: 500, quantity: 5) } #2500
          @items_4.each { |item| create(:invoice_items, invoice: @invoice_3, item: item, unit_price: 200, quantity: 10) } # 2000
          @items_5.each { |item| create(:invoice_items, invoice: @invoice_3, item: item, unit_price: 500, quantity: 15) } #7500
          @items_6.each { |item| create(:invoice_items, invoice: @invoice_4, item: item, unit_price: 200, quantity: 5) } #1000

          @transaction_1 = create_list(:transaction, 2, invoice: @invoice_1, result: :failed)
          @transaction_2 = create_list(:transaction, 2, invoice: @invoice_1, result: :failed)
          @transaction_3 = create_list(:transaction, 2, invoice: @invoice_2, result: :success)
          @transaction_4 = create_list(:transaction, 2, invoice: @invoice_2, result: :success)
          @transaction_5 = create_list(:transaction, 2, invoice: @invoice_3, result: :failed)
          @transaction_6 = create_list(:transaction, 2, invoice: @invoice_3, result: :success)
          @transaction_7 = create_list(:transaction, 2, invoice: @invoice_4, result: :success)
          @transaction_8 = create_list(:transaction, 2, invoice: @invoice_4, result: :failed)
        end
        
        it 'I see the names of the top 5 merchants by total revenue generated' do
          visit admin_merchants_path
          #orderly based off of top revenue
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

          expect(page).to_not have_content(merchant_5.name)
        end

        it 'I see that each merchant name links to the admin merchant show page for that merchant' do
          visit admin_merchants_path

          click_button "#{@merchant_1.name}"
          expect(current_path).to eq(admin_merchant_path(@merchant_1))
        end
        
        it 'I see the total revenue generated next to each merchant name' do
          visit admin_merchants_path
          #use within blocks to find on page
        end
      end
    end
  end
end