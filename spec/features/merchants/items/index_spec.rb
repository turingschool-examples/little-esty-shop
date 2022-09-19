require 'rails_helper'

RSpec.describe 'Merchant Items Index' do
    before :each do
        @merchant_1 = Merchant.create!(name: "Bread Pitt")
        @merchant_2 = Merchant.create!(name: "Carrie Breadshaw")

        @item_1 = Item.create!(name: "Rye", description: "Great for Reubens", unit_price: 10, merchant_id: @merchant_2.id, status: :Enabled)
        @item_2 = Item.create!(name: "Challah", description: "So delicious", unit_price: 10, merchant_id: @merchant_2.id)
        @item_3 = Item.create!(name: "Wonder Bread", description: "Basic", unit_price: 3, merchant_id: @merchant_1.id)
    end
    
    it 'shows the name of all the items of the merchant' do
        visit "/merchant/#{@merchant_2.id}/items"

        expect(page).to have_content("Carrie Breadshaw")
        expect(page).to have_content("Rye")
        expect(page).to have_content("Challah")
        expect(page).to_not have_content("Bread Pitt")
        expect(page).to_not have_content("Wonder Bread")
    end

    it 'has a link to the show page of each merchant item' do
        visit "/merchant/#{@merchant_2.id}/items"

        expect(page).to have_link(@item_1.name)
        expect(page).to have_link(@item_2.name)
        click_link "#{@item_1.name}"

        expect(current_path).to eq("/merchant/#{@merchant_2.id}/items/#{@item_1.id}")
    end

    it "has a button that can enable/disable items" do
        item_4 = Item.create!(name: "Rye", description: "Great for Reubens", unit_price: 10, merchant_id: @merchant_2.id, status: :Enabled)
        visit "/merchant/#{@merchant_2.id}/items"

        within("#enabled_item-#{item_4.id}") do
          expect(page).to have_button("Disable")
          click_button("Disable")
        end
        
        expect(current_path).to eq("/merchant/#{@merchant_2.id}/items")
       # expect(item_4.status).to eq("Disabled")

        within("#disabled_item-#{item_4.id}") do
            expect(page).to have_button("Enable")
            click_button "Enable"
        end
      expect(current_path).to eq("/merchant/#{@merchant_2.id}/items")
    end

    it 'has link to create a new item' do
        visit "/merchant/#{@merchant_2.id}/items"
        click_link "New Item"
        expect(current_path).to eq("/merchant/#{@merchant_2.id}/items/new")
    end

    describe 'top_five_items' do
        before :each do
            @merchant_1 = Merchant.create!(name: "Bread Pitt")
            @merchant_2 = Merchant.create!(name: "Carrie Breadshaw")
            @merchant_3 = Merchant.create!(name: "Sheena Yeaston")
            @merchant_4 = Merchant.create!(name: "Taylor Sift")
            @merchant_5 = Merchant.create!(name: "Rye-n Rye-nolds")
            @merchant_6 = Merchant.create!(name: "Bread Paisley")
            @item_1 = Item.create!(name: "Sourdough", description: "leavened, wild yeast", unit_price: 400, merchant_id: @merchant_1.id)
            @item_2 = Item.create!(name: "Baguette", description: "Soft, french", unit_price: 900, merchant_id: @merchant_1.id)
            @item_3 = Item.create!(name: "Brioche", description: "Rich, rolled", unit_price: 1100, merchant_id: @merchant_1.id)
            @item_4 = Item.create!(name: "Ciabatta", description: "Italy's answer to the baguette", unit_price: 1800, merchant_id: @merchant_1.id)
            @item_5 = Item.create!(name: "Rye Bread", description: "Too many jokes to be had", unit_price: 500, merchant_id: @merchant_1.id)
            @item_6 = Item.create!(name: "Struggle Loaf", description: "Nobody wants it but it's ever-present", unit_price: 500, merchant_id: @merchant_1.id)
      
            @customer_1 = Customer.create!(first_name: "Meat", last_name: "Loaf")
            @customer_2 = Customer.create!(first_name: "Shannon", last_name: "Dougherty")
            @customer_3 = Customer.create!(first_name: "Puff", last_name: "Daddy")
            @customer_4 = Customer.create!(first_name: "Walter", last_name: "Wheat")
            @customer_5 = Customer.create!(first_name: "David", last_name: "Dowie")
            @customer_6 = Customer.create!(first_name: "Clint", last_name: "Yeastwood")
      
            @invoice_1 = Invoice.create!(status: :completed, customer_id: @customer_1.id)
            @invoice_2 = Invoice.create!(status: :completed, customer_id: @customer_2.id)
            @invoice_3 = Invoice.create!(status: :completed, customer_id: @customer_3.id)
            @invoice_4 = Invoice.create!(status: :completed, customer_id: @customer_4.id)
            @invoice_5 = Invoice.create!(status: :completed, customer_id: @customer_5.id)
            @invoice_6 = Invoice.create!(status: :completed, customer_id: @customer_6.id)
      
            @transaction_1 = Transaction.create!(result: :success, invoice_id: @invoice_1.id, credit_card_number: "255448968")

            @invoice_item_1 = InvoiceItem.create!(quantity: 4, unit_price: 850, status: 2, item_id: @item_1.id, invoice_id: @invoice_1.id)
            @invoice_item_2 = InvoiceItem.create!(quantity: 2, unit_price: 1300, status: 2, item_id: @item_2.id, invoice_id: @invoice_1.id)
            @invoice_item_3 = InvoiceItem.create!(quantity: 3, unit_price: 999, status: 2, item_id: @item_3.id, invoice_id: @invoice_1.id)
            @invoice_item_4 = InvoiceItem.create!(quantity: 2, unit_price: 1200, status: 2, item_id: @item_4.id, invoice_id: @invoice_1.id)
            @invoice_item_5 = InvoiceItem.create!(quantity: 3, unit_price: 500, status: 2, item_id: @item_5.id, invoice_id: @invoice_1.id)
            #@invoice_item_6 = InvoiceItem.create!(quantity: 3, unit_price: 444, status: 2, item_id: @item_5.id, invoice_id: @invoice_1.id)
        end
    
        it 'will show the top 5 merchants by revenue' do
          visit "/merchant/#{@merchant_1.id}/items"
          expect(page).to have_content("Top Five Items")
          save_and_open_page
          within '.top_items' do
                expect("Sourdough").to appear_before("Brioche")
                expect("Brioche").to appear_before("Baguette")
                expect("Brioche").to appear_before("Ciabatta")
                expect("Ciabatta").to appear_before("Rye Bread")
                expect(page).to_not have_content("Struggle Loaf")
                expect(page).to have_link("Sourdough")
          end
    
            within("#top_item-#{@item_1.id}") do
              expect(page).to have_content("$3,400.00")
            end
        end
    end
end