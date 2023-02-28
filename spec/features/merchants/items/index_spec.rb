require 'rails_helper'

RSpec.describe 'Merchant Items Index' do
  before (:each) do
    Merchant.destroy_all
		Customer.destroy_all
		Invoice.destroy_all
		Item.destroy_all
		Transaction.destroy_all
		InvoiceItem.destroy_all

		@carlos = Merchant.create!(name: "Carlos Jenkins")
		@pete = Merchant.create!(name: "Pete Smith") 

    @scarf = @pete.items.create!(name: "Scarf", description: "scarf, knitted", unit_price: 350) 
		@tshirt = @pete.items.create!(name: "Tshirt", description: "tshirt, screenprinted", unit_price: 250)

    @bowl = @carlos.items.create!(name: "Bowl", description: "it's a bowl", unit_price: 350) 
		@knife = @carlos.items.create!(name: "Knife", description: "it's a knife", unit_price: 250)
  end
  
  describe 'As a merchant, when I visit my merchant items index page' do
    it 'I see a list of the names of all of my items, no items from other merchants' do
      visit "/merchants/#{@carlos.id}/items"
      expect(page).to have_content("Bowl")
      expect(page).to have_content("Knife")

      expect(page).to_not have_content("Scarf")
      expect(page).to_not have_content("Tshirt")
    end

    it 'Next to each item name I see a button to disable or enable that item' do
      visit "/merchants/#{@carlos.id}/items"

      within "#id-#{@bowl.id}" do
        expect(page).to have_button("Enable")
        click_button "Enable"

        expect(current_path).to eq("/merchants/#{@carlos.id}/items")
        expect(page).to have_button("Disable")
        click_button "Disable"

        expect(current_path).to eq("/merchants/#{@carlos.id}/items")
        expect(page).to have_button("Enable")
      end
    end

    describe 'I see two sections, one for "Enabled Items" and one for "Disabled Items' do
      it 'I see that each Item is listed in the appropriate section' do
        visit "/merchants/#{@carlos.id}/items"

        within "#disabled-items" do
          expect(page).to have_content("Disabled Items")
          expect(page).to have_content("Bowl")
          expect(page).to have_content("Knife")
          
          expect(page).to have_button("Enable")
          expect(page).to_not have_button("Disable")

          first(:button, "Enable").click
          expect(page).to_not have_content("Bowl")
        end

        within "#enabled-items" do
          expect(page).to have_content("Enabled Items")
          expect(page).to have_content("Bowl")
          expect(page).to_not have_content("Knife")

          first(:button, "Disable").click
          expect(page).to_not have_content("Bowl")
        end

        within "#disabled-items" do
          expect(page).to have_content("Bowl")
        end
      end
    end

    describe 'I see a link to create a new item' do
      it "When I click on the link, I am taken to a form to add item information" do
        visit "/merchants/#{@carlos.id}/items"
        expect(page).to have_link("Create New Item")

        click_link "Create New Item"
        expect(current_path).to eq("/merchants/#{@carlos.id}/items/new")
      end

      describe 'After a new item form is submitted' do
        it 'I see the item I just created in the items list with disabled status' do
          visit "/merchants/#{@carlos.id}/items/new"

          fill_in :name, with: "Teacup"
          fill_in :description, with: "Here's a Teacup"
          fill_in :unit_price, with: 300
  
          click_button "Create Item"
          
          expect(page).to have_content("Teacup")
          expect(current_path).to eq("/merchants/#{@carlos.id}/items")
        end

        it "If the information is not valid or missing, item is not created" do
          visit "/merchants/#{@carlos.id}/items/new"

          fill_in :name, with: ""
          fill_in :description, with: "Here's a Teacup"
          fill_in :unit_price, with: 300

          click_button "Create Item"
          expect(current_path).to eq("/merchants/#{@carlos.id}/items/new")
          expect(page).to have_content("Item not created: Required information missing")
        end
      end
    end

    describe '5 Most Popular Items' do
      before do
        @merchant = Merchant.create(name: "Handmades")

        @cust1 = FactoryBot.create(:customer)
        @cust2 = FactoryBot.create(:customer)

        @inv1 = @cust1.invoices.create!(status: 1)
        @inv2 = @cust1.invoices.create!(status: 1)
        @inv3 = @cust1.invoices.create!(status: 1)
        @inv4 = @cust2.invoices.create!(status: 1)
        @inv5 = @cust2.invoices.create!(status: 1)
        @inv6 = @cust2.invoices.create!(status: 1)

        @trans1 = @inv1.transactions.create!(credit_card_number: 5555555555555555, credit_card_expiration_date: nil, result: 0)
        @trans1_5 = @inv1.transactions.create!(credit_card_number: 5555555555555555, credit_card_expiration_date: nil, result: 0)
        @trans2 = @inv2.transactions.create!(credit_card_number: 5555555555555555, credit_card_expiration_date: nil, result: 0)
        @trans3 = @inv2.transactions.create!(credit_card_number: 5555555555555555, credit_card_expiration_date: nil, result: 0)
        @trans4 = @inv3.transactions.create!(credit_card_number: 5555555555555555, credit_card_expiration_date: nil, result: 0)
        @trans5 = @inv3.transactions.create!(credit_card_number: 5555555555555555, credit_card_expiration_date: nil, result: 0)
        @trans6 = @inv3.transactions.create!(credit_card_number: 5555555555555555, credit_card_expiration_date: nil, result: 0)
        @trans7 = @inv4.transactions.create!(credit_card_number: 5555555555555555, credit_card_expiration_date: nil, result: 0)
        @trans8 = @inv4.transactions.create!(credit_card_number: 5555555555555555, credit_card_expiration_date: nil, result: 0)
        @trans9 = @inv4.transactions.create!(credit_card_number: 5555555555555555, credit_card_expiration_date: nil, result: 0)
        @trans10 = @inv4.transactions.create!(credit_card_number: 5555555555555555, credit_card_expiration_date: nil, result: 0)
        @trans11 = @inv5.transactions.create!(credit_card_number: 5555555555555555, credit_card_expiration_date: nil, result: 0)
        @trans12 = @inv5.transactions.create!(credit_card_number: 5555555555555555, credit_card_expiration_date: nil, result: 0)
        @trans13 = @inv5.transactions.create!(credit_card_number: 5555555555555555, credit_card_expiration_date: nil, result: 0)
        @trans14 = @inv5.transactions.create!(credit_card_number: 5555555555555555, credit_card_expiration_date: nil, result: 0)
        @trans15 = @inv5.transactions.create!(credit_card_number: 5555555555555555, credit_card_expiration_date: nil, result: 0)
        @trans16 = @inv6.transactions.create!(credit_card_number: 5555555555555555, credit_card_expiration_date: nil, result: 0)

        @bowl = @merchant.items.create!(name: "Bowl", description: "it's a bowl", unit_price: 350) 
        @knife = @merchant.items.create!(name: "Knife", description: "it's a knife", unit_price: 300) 
        @spoon = @merchant.items.create!(name: "Spoon", description: "it's a spoon", unit_price: 275) 
        @plate = @merchant.items.create!(name: "Plate", description: "it's a plate", unit_price: 250) 
        @fork = @merchant.items.create!(name: "Fork", description: "it's a fork", unit_price: 100) 
        @pan = @merchant.items.create!(name: "Pan", description: "it's a pan", unit_price: 250) 
          
        InvoiceItem.create!(item_id: @bowl.id, invoice_id: @inv1.id, quantity: 10, unit_price: 350, status: 1)
        InvoiceItem.create!(item_id: @knife.id, invoice_id: @inv1.id, quantity: 9, unit_price: 300, status: 1)
        InvoiceItem.create!(item_id: @plate.id, invoice_id: @inv1.id, quantity: 10, unit_price: 201, status: 1)
        InvoiceItem.create!(item_id: @spoon.id, invoice_id: @inv1.id, quantity: 8, unit_price: 2500, status: 1)
        InvoiceItem.create!(item_id: @fork.id, invoice_id: @inv5.id, quantity: 1, unit_price: 14, status: 1)
        InvoiceItem.create!(item_id: @pan.id, invoice_id: @inv6.id, quantity: 6, unit_price: 15, status: 1)
      end

      it 'I see the names of the top 5 most popular items ranked by total revenue generated' do

        visit "/merchants/#{@carlos.id}/items"

        within "div#top-items" do
          expect(page).to have_content("Top Items")
          expect("Spoon").to appear_before("Bowl")
          expect("Bowl").to appear_before("Knife")
          expect("Knife").to appear_before("Plate")
          expect("Plate").to appear_before("Pan")

          expect("Revenue: 20000").to appear_before("Revenue: 3500")
          expect("Revenue: 3500").to appear_before("Revenue: 2700")
          expect("Revenue: 2700").to appear_before("Revenue: 2010")
          expect("Revenue: 2010").to appear_before("Revenue: 90")

        end
      end

      it 'next to each top5 item, I see the date with most sales for each item' do
        visit "/merchants/#{@carlos.id}/items"

        within "#top-items" do
          expect(page).to have_content("Top selling date for #{@spoon.name} was #{@inv1.created_at.strftime('%m/%d/%Y')}")
          expect(page).to have_content("Top selling date for #{@bowl.name} was #{@inv1.created_at.strftime('%m/%d/%Y')}")
          expect(page).to have_content("Top selling date for #{@knife.name} was #{@inv1.created_at.strftime('%m/%d/%Y')}")
          expect(page).to have_content("Top selling date for #{@plate.name} was #{@inv1.created_at.strftime('%m/%d/%Y')}")
          expect(page).to have_content("Top selling date for #{@pan.name} was #{@inv6.created_at.strftime('%m/%d/%Y')}")
        end
      end
    end
  end
end