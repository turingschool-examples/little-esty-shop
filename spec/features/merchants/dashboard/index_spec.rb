require 'rails_helper'

RSpec.describe "Dashboard", type: :feature do
  before(:each) do
    @merchant = create(:merchant, name: "Trader Bob's")

    @customer_1 = create(:customer)
    @customer_2 = create(:customer)
    @customer_3 = create(:customer)
    @customer_4 = create(:customer)
    @customer_5 = create(:customer)
    @customer_6 = create(:customer)

    @invoice_1 = create(:invoice, customer_id: @customer_1.id, created_at: Date.new(2023,1,1))
    @invoice_2 = create(:invoice, customer_id: @customer_2.id, created_at: Date.new(2023,1,2))
    @invoice_3 = create(:invoice, customer_id: @customer_3.id, created_at: Date.new(2023,1,3))
    @invoice_4 = create(:invoice, customer_id: @customer_4.id, created_at: Date.new(2023,1,4))
    @invoice_5 = create(:invoice, customer_id: @customer_5.id, created_at: Date.new(2023,1,5))
    @invoice_6 = create(:invoice, customer_id: @customer_6.id, created_at: Date.new(2023,1,6))
    @invoice_7 = create(:invoice, customer_id: @customer_6.id, created_at: Date.new(2023,1,7))

    @item_1 = create(:item, merchant: @merchant)
    @item_2 = create(:item, merchant: @merchant)
    @item_3 = create(:item, merchant: @merchant)

    @invoice_item_1 = create(:invoice_item, item: @item_1, invoice: @invoice_1, quantity: 1, status: "packaged", created_at: Date.new(2023,1,1))
    @invoice_item_2 = create(:invoice_item, item: @item_1, invoice: @invoice_2, quantity: 1, status: "packaged", created_at: Date.new(2023,1,2))
    @invoice_item_3 = create(:invoice_item, item: @item_1, invoice: @invoice_3, quantity: 1, status: "packaged", created_at: Date.new(2023,1,3))
    @invoice_item_4 = create(:invoice_item, item: @item_1, invoice: @invoice_4, quantity: 1, status: "packaged", created_at: Date.new(2023,1,4))
    @invoice_item_5 = create(:invoice_item, item: @item_1, invoice: @invoice_5, quantity: 1, status: "packaged", created_at: Date.new(2023,1,5))
    @invoice_item_6 = create(:invoice_item, item: @item_2, invoice: @invoice_6, quantity: 1, status: "packaged", created_at: Date.new(2023,1,6))
    @invoice_item_7 = create(:invoice_item, item: @item_3, invoice: @invoice_7, quantity: 1, status: "shipped", created_at: Date.new(2023,1,7))

    create(:transaction, invoice_id: @invoice_1.id, result: 0)
    2.times { create(:transaction, invoice_id: @invoice_2.id, result: 0) }
    3.times { create(:transaction, invoice_id: @invoice_3.id, result: 0) }
    4.times { create(:transaction, invoice_id: @invoice_4.id, result: 0) }
    5.times { create(:transaction, invoice_id: @invoice_5.id, result: 0) }
    3.times { create(:transaction, invoice_id: @invoice_7.id, result: 1) }

    contributors_json_response = File.open("./fixtures/contributors.json")
    pulls_json_response = File.open("./fixtures/pulls.json")
    repo_json_response = File.open("./fixtures/repo.json")

    stub_request(:get, "https://api.github.com/repos/aj-bailey/little-esty-shop").
      to_return(status: 200, body: repo_json_response)

    stub_request(:get, "https://api.github.com/repos/aj-bailey/little-esty-shop/pulls?state=closed").
      to_return(status: 200, body: pulls_json_response)

    stub_request(:get, "https://api.github.com/repos/aj-bailey/little-esty-shop/contributors").
      to_return(status: 200, body: contributors_json_response)

    visit "/merchants/#{@merchant.id}/dashboard"
  end

  describe "User story 1" do
    describe "When I visit my merchant dashboard" do
      it "As a merchant, when I visit my merchant dashboard 
        (/merchants/:merchant_id/dashboard) then I see the name of my merchant" do

        expect(page).to have_content("Trader Bob's")
      end
    end
  end

  describe "User story 2" do
    describe "When I visit my merchant dashboard" do
      it "shows a link to my merchant items index (/merchants/merchant_id/items)" do
        expect(page).to have_link("Items", href: "/merchants/#{@merchant.id}/items")
      end

      it "show a link to my merchant invoices index (/merchants/merchant_id/invoices)" do
        expect(page).to have_link("Invoices", href: "/merchants/#{@merchant.id}/invoices")
      end
    end
  end

  describe "User story 3" do
    describe "When I visit my merchant dashboard" do
      it "I see the names of the top 5 customers who have conducted the largest number of successful transactions with my merchant
        and next to each customer name I see the number of successful transactions they have conducted with my merchant" do  
        customer_5_full_name = "#{@customer_5.first_name} #{@customer_5.last_name}"
        customer_4_full_name = "#{@customer_4.first_name} #{@customer_4.last_name}"
        customer_3_full_name = "#{@customer_3.first_name} #{@customer_3.last_name}"
        customer_2_full_name = "#{@customer_2.first_name} #{@customer_2.last_name}"
        customer_1_full_name = "#{@customer_1.first_name} #{@customer_1.last_name}"
  
        expect("#{customer_5_full_name} - 5 purchases").to appear_before("#{customer_4_full_name} - 4 purchases")
        expect("#{customer_4_full_name} - 4 purchases").to appear_before("#{customer_3_full_name} - 3 purchases")
        expect("#{customer_3_full_name} - 3 purchases").to appear_before("#{customer_2_full_name} - 2 purchases")
        expect("#{customer_2_full_name} - 2 purchases").to appear_before("#{customer_1_full_name} - 1 purchases")
      end
    end
  end

  describe "User Story 4" do
    describe "Items Ready to Ship" do
      it "shows a list of items that have been ordered yet have not been shipped" do
        expect(page).to have_content(@item_1.name)
        expect(page).to have_content(@item_2.name)
      end

      it "shows the id of the invoice that ordered the item" do
        expect(page).to have_content("Invoice ##{@invoice_1.id}")
        expect(page).to have_content("Invoice ##{@invoice_2.id}")
      end

      it "each invoice id is a link to my merchant's invoice show page" do
        expect(page).to have_link("Invoice ##{@invoice_1.id}",
        href: "/merchants/#{@merchant.id}/invoices/#{@invoice_1.id}")
      end
    end
  end

  describe "User Story 5" do
    it "displays the date that the invoice was created and is formatted WeekDay, Month Day, Year" do
      within("#items_ready_to_ship") {

        expect("Sunday, January 1, 2023").to appear_before("Monday, January 2, 2023")
        expect("Monday, January 2, 2023").to appear_before("Tuesday, January 3, 2023")
        expect("Tuesday, January 3, 2023").to appear_before("Wednesday, January 4, 2023")
        expect("Wednesday, January 4, 2023").to appear_before("Thursday, January 5, 2023")
        expect("Thursday, January 5, 2023").to appear_before("Friday, January 6, 2023")
        expect(page).to_not have_content("Saturday, January 7, 2023")
      }
    end
  end
end