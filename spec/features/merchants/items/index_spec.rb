require 'rails_helper'

RSpec.describe "Merchant_Items#Index", type: :feature do
  before(:each) do
    @merchant = create(:merchant, name: "Trader Bob's")
    @merchant_2 = create(:merchant, name: "Trader Bob's deux")

    @customer_1 = create(:customer)
    @customer_2 = create(:customer)
    @customer_3 = create(:customer)
    @customer_4 = create(:customer)
    @customer_5 = create(:customer)
    @customer_6 = create(:customer)

    @invoice_1 = create(:invoice, customer_id: @customer_1.id, created_at: Date.new(2023,1,1))
    @invoice_2 = create(:invoice, customer_id: @customer_2.id, created_at: Date.new(2022,1,1))
    @invoice_3 = create(:invoice, customer_id: @customer_3.id, created_at: Date.new(2021,1,1))
    @invoice_4 = create(:invoice, customer_id: @customer_4.id, created_at: Date.new(2020,1,1))
    @invoice_5 = create(:invoice, customer_id: @customer_5.id, created_at: Date.new(2019,1,1))
    @invoice_6 = create(:invoice, customer_id: @customer_6.id, created_at: Date.new(2018,1,1))
    @invoice_7 = create(:invoice, customer_id: @customer_6.id, created_at: Date.new(2017,1,1))

    @item_1 = create(:item, merchant: @merchant, name: "GoldenEye 007")
    @item_2 = create(:item, merchant: @merchant, name: "Connect-Four")
    @item_3 = create(:item, merchant: @merchant_2)
    @item_4 = create(:item, merchant: @merchant, name: "Chris Beats", status: "Enabled")
    @item_5 = create(:item, merchant: @merchant, name: "Super Adbul World", status: "Enabled")
    @item_6 = create(:item, merchant: @merchant, name: "BattleShip")
    @item_7 = create(:item, merchant: @merchant, name: "Khoa-Or-Peace")

    @invoice_item_1 = create(:invoice_item, item: @item_1, invoice: @invoice_1, quantity: 1, status: "packaged", created_at: Date.new(2023,1,1))
    @invoice_item_2 = create(:invoice_item, item: @item_1, invoice: @invoice_2, quantity: 1, status: "packaged", created_at: Date.new(2023,1,2))
    @invoice_item_3 = create(:invoice_item, item: @item_1, invoice: @invoice_3, quantity: 1, status: "packaged", created_at: Date.new(2023,1,3))
    @invoice_item_4 = create(:invoice_item, item: @item_1, invoice: @invoice_4, quantity: 1, status: "packaged", created_at: Date.new(2023,1,4))
    @invoice_item_5 = create(:invoice_item, item: @item_1, invoice: @invoice_5, quantity: 1, status: "packaged", created_at: Date.new(2023,1,5))
    @invoice_item_6 = create(:invoice_item, item: @item_2, invoice: @invoice_6, quantity: 1, status: "packaged", created_at: Date.new(2023,1,6))
    @invoice_item_7 = create(:invoice_item, item: @item_3, invoice: @invoice_7, quantity: 1, status: "shipped", created_at: Date.new(2023,1,7))

    create(:transaction, invoice_id: @invoice_1.id, result: 0)
    create(:transaction, invoice_id: @invoice_2.id, result: 0)
    create(:transaction, invoice_id: @invoice_3.id, result: 0)
    create(:transaction, invoice_id: @invoice_4.id, result: 0)
    create(:transaction, invoice_id: @invoice_5.id, result: 0)
    create(:transaction, invoice_id: @invoice_7.id, result: 0)


    contributors_json_response = File.open("./fixtures/contributors.json")
    pulls_json_response = File.open("./fixtures/pulls.json")
    repo_json_response = File.open("./fixtures/repo.json")

    stub_request(:get, "https://api.github.com/repos/aj-bailey/little-esty-shop").
      to_return(status: 200, body: repo_json_response)

    stub_request(:get, "https://api.github.com/repos/aj-bailey/little-esty-shop/pulls?state=closed").
      to_return(status: 200, body: pulls_json_response)

    stub_request(:get, "https://api.github.com/repos/aj-bailey/little-esty-shop/contributors").
      to_return(status: 200, body: contributors_json_response)

    
    visit "/merchants/#{@merchant.id}/items"
  end

  describe "User Story 6" do
    it "shows a list of all the merchant items" do
      expect(page).to have_content(@item_1.name)
      expect(page).to have_content(@item_2.name)
      expect(page).to_not have_content(@item_3.name)
    end
  end

  describe "User Story 7" do
    it "the item names are links to the appropriate show page" do
      within("#merchant_item_disabled-#{@item_1.id}") do
        click_link(@item_1.name, :match => :one)
      end
      expect(current_path).to eq("/merchants/#{@merchant.id}/items/#{@item_1.id}")
    end
  end

  describe "User Story 9" do
    it "Next to each item name I see a button to disable or enable that item. When I click this button 
      then I am redirected back to the items index and I see that the items status has changed" do
      
      within("#merchant_item_disabled-#{@item_1.id}")  {
        expect(page).to have_button("Enable")
        expect(page).to_not have_button("Disable")
        click_button "Enable"
      }
 
      within("#merchant_item_enabled-#{@item_1.id}")  {
        expect(page).to_not have_button("Enable")
        expect(page).to have_button("Disable")
        click_button "Disable"
      }
      
      within("#merchant_item_disabled-#{@item_1.id}")  {
        expect(page).to have_button("Enable")
      }
      expect(current_path).to eq("/merchants/#{@merchant.id}/items")
    end
  end

  describe "User Story 10" do
    it "I see two sections, one for 'Enabled Items' and one for 'Disabled Items' 
      And I see that each Item is listed in the appropriate section" do
      expect(page).to have_content("Enabled Items")
      
      within("#disabled_items")  {
        expect(page).to have_content("#{@item_1.name}")
        expect(page).to have_content("#{@item_2.name}")
      }
      
      expect(page).to have_content("Disabled Items")
      
      within("#enabled_items")  {
        expect(page).to have_content("#{@item_4.name}")
        expect(page).to have_content("#{@item_5.name}")
      }
    end
  end

  describe "User Story 11" do
    it "I see a link to create a new item, when I click on the link,
      I am taken to a form that allows me to add item information." do
      
      click_link("New Item")
      expect(current_path).to eq("/merchants/#{@merchant.id}/items/new")
    end

    it "I see the item I just created displayed in the list of items.
      And I see my item was created with a default status of disabled." do

      click_link("New Item")
      fill_in "Name", with: "Corn"
      fill_in "Description", with: "It's the most beautiful thing!"
      fill_in "Unit price", with: 5
      click_button "Create Item"
      
      expect(page).to have_content("Corn")
    end
  end

  describe "User Story 12" do
    before(:each) do
      invoice_item_8 = create(:invoice_item, item: @item_1, invoice: @invoice_1, unit_price: 9000000, quantity: 3)
      invoice_item_9 = create(:invoice_item, item: @item_2, invoice: @invoice_2, unit_price: 8000000, quantity: 3)
      invoice_item_10 = create(:invoice_item, item: @item_4, invoice: @invoice_3, unit_price: 7000000, quantity: 3)
      invoice_item_11 = create(:invoice_item, item: @item_5, invoice: @invoice_4, unit_price: 6000000, quantity: 3)
      invoice_item_12 = create(:invoice_item, item: @item_6, invoice: @invoice_5, unit_price: 5000000, quantity: 3)
      invoice_item_13 = create(:invoice_item, item: @item_7, invoice: @invoice_6, unit_price: 4000000, quantity: 3)
      
      visit "/merchants/#{@merchant.id}/items"
    end
    
    it "lists the names of the top 5 most popular items ranked by total revenue generated" do
      within("#5_most_popular_items") do
        expect(page).to have_content(@item_1.name)
        expect(page).to have_content(@item_2.name)
        expect(page).to have_content(@item_4.name)
        expect(page).to have_content(@item_5.name)
        expect(page).to have_content(@item_6.name)
        
        expect(@item_1.name).to appear_before(@item_2.name)
        expect(@item_2.name).to appear_before(@item_4.name)
        expect(@item_4.name).to appear_before(@item_5.name)
        expect(@item_5.name).to appear_before(@item_6.name)
      end
    end

    it "each item name links to my merchant item show page for that item" do
      within("#5_most_popular_items") do
        expect(page).to have_link(@item_1.name, :href => "/merchants/#{@merchant.id}/items/#{@item_1.id}")
        expect(page).to have_link(@item_2.name, :href => "/merchants/#{@merchant.id}/items/#{@item_2.id}")
        expect(page).to have_link(@item_4.name, :href => "/merchants/#{@merchant.id}/items/#{@item_4.id}")
        expect(page).to have_link(@item_5.name, :href => "/merchants/#{@merchant.id}/items/#{@item_5.id}")
        expect(page).to have_link(@item_6.name, :href => "/merchants/#{@merchant.id}/items/#{@item_6.id}")
      end
    end

    it "And I see the total revenue generated next to each item name" do  
      within("#5_most_popular_items") do 
        
        expect(page).to have_content("#{@item_2.name} - $240,000 in sales")
        expect(page).to have_content("#{@item_4.name} - $210,000 in sales")
        expect(page).to have_content("#{@item_5.name} - $180,000 in sales")
        expect(page).to have_content("#{@item_6.name} - $150,000 in sales")
      end
    end
  end

  describe "User Story 13" do
    before(:each) do
      invoice_item_8 = create(:invoice_item, item: @item_1, invoice: @invoice_1, unit_price: 9000000, quantity: 3)
      invoice_item_9 = create(:invoice_item, item: @item_2, invoice: @invoice_2, unit_price: 8000000, quantity: 3)
      invoice_item_10 = create(:invoice_item, item: @item_4, invoice: @invoice_3, unit_price: 7000000, quantity: 3)
      invoice_item_11 = create(:invoice_item, item: @item_5, invoice: @invoice_4, unit_price: 6000000, quantity: 3)
      invoice_item_12 = create(:invoice_item, item: @item_6, invoice: @invoice_5, unit_price: 5000000, quantity: 3)
      invoice_item_13 = create(:invoice_item, item: @item_7, invoice: @invoice_6, unit_price: 4000000, quantity: 3)
      
      visit "/merchants/#{@merchant.id}/items"
    end

    it "next to each of the 5 most popular items I see the date with the most sales 
      for each item and I see a label “Top selling date for was " do
        within("#5_most_popular_items") do     
          expect(page).to have_content("Top day for #{@item_1.name} was 1/1/23")
          expect(page).to have_content("Top day for #{@item_2.name} was 1/1/22")
          expect(page).to have_content("Top day for #{@item_4.name} was 1/1/21")
          expect(page).to have_content("Top day for #{@item_5.name} was 1/1/20")
          expect(page).to have_content("Top day for #{@item_6.name} was 1/1/19")
      end
    end
  end
end