require 'rails_helper'

RSpec.describe "The Admin Merchants Index" do
  before(:each) do
    @merchant_1 = create(:merchant)
    @merchant_2 = create(:merchant, status: 1)
    @merchant_3 = create(:merchant)
    @merchant_4 = create(:merchant)
    @merchant_5 = create(:merchant)
    @merchant_6 = create(:merchant)
   
    contributors_json_response = File.open("./fixtures/contributors.json")
    pulls_json_response = File.open("./fixtures/pulls.json")
    repo_json_response = File.open("./fixtures/repo.json")

    stub_request(:get, "https://api.github.com/repos/aj-bailey/little-esty-shop").
      to_return(status: 200, body: repo_json_response)

    stub_request(:get, "https://api.github.com/repos/aj-bailey/little-esty-shop/pulls?state=closed").
      to_return(status: 200, body: pulls_json_response)

    stub_request(:get, "https://api.github.com/repos/aj-bailey/little-esty-shop/contributors").
      to_return(status: 200, body: contributors_json_response)
  
    
    visit admin_merchants_path
  end
  describe "User Story 24" do
    it "When an admin visits the merchants index (/admin/merchants) they see the name of each merchant in the system" do

      expect(page).to have_content(@merchant_1.name)
      expect(page).to have_content(@merchant_2.name)
      expect(page).to have_content(@merchant_3.name)
      expect(page).to have_content(@merchant_4.name)
    end
  end

  describe "User Story 25" do
    it "When an admin visits the merchants index (/admin/merchants) and they click on the merchant's name, they are taken to that merchant's show page And they see the name of that merchant" do
      click_link(@merchant_1.name)

      expect(current_path).to eq(admin_merchant_path(@merchant_1))
      expect(page).to have_content(@merchant_1.name)
      expect(page).to_not have_content(@merchant_2.name)
    end
  end

  describe "User Story 27" do
    it "shows a button next to each merchant to disable or enable that merchant. When I click this button, I am redirected back to the admin merchants index, and I see that the merchant's status has changed" do

      within("#Merchant-#{@merchant_1.id}")  {
        expect(page).to_not have_button("Enable")
        expect(page).to have_button("Disable")
        click_button "Disable"
      }
 
      within("#Merchant-#{@merchant_1.id}")  {
        expect(page).to have_button("Enable")
      }

      expect(current_path).to eq(admin_merchants_path)

      within("#Merchant-#{@merchant_2.id}")  {
        expect(page).to have_button("Enable")
        expect(page).to_not have_button("Disable")

        click_button "Enable"
      }
      
      within("#Merchant-#{@merchant_2.id}")  {
        expect(page).to have_button("Disable")
      }
    end
  end

  describe "User Story 28" do
    it "shows two sections for Enabled and Disabled merchants with each merchant appropriately listed in the sections" do
      within("#Enabled_Merchants") {
        expect(page).to have_content(@merchant_1.name)
        expect(page).to have_content(@merchant_3.name)
        expect(page).to have_content(@merchant_4.name)
      }

      within("#Disabled_Merchants") {
        expect(page).to have_content(@merchant_2.name)
      }
    end
  end

  describe "User Story 29" do
    it "When and Admin visits the admin merchants index, they see a link to create a new merchant and when they click on the link, they are taken to the new admin merchant page" do
      expect(page).to have_link("New Merchant", href: new_admin_merchant_path)

      click_link "New Merchant"

      expect(current_path).to eq(new_admin_merchant_path)
    end
  end

  context "Admin Merchants Top Five" do
    before(:each) do
      spendy_customer = create(:customer)

      item_1 = create(:item, merchant: @merchant_3)
      item_2 = create(:item, merchant: @merchant_1)
      item_3 = create(:item, merchant: @merchant_5)
      item_4 = create(:item, merchant: @merchant_2)
      item_5 = create(:item, merchant: @merchant_4)
      item_6 = create(:item, merchant: @merchant_6)
      #merchant 3
      invoice_1 = create(:invoice, customer: spendy_customer, created_at: Date.new(2023,1,1))
      invoice_2 = create(:invoice, customer: spendy_customer, created_at: Date.new(2023,1,1))
      invoice_3 = create(:invoice, customer: spendy_customer)
      #merchant 1
      invoice_4 = create(:invoice, customer: spendy_customer, created_at: Date.new(2023,1,2))
      invoice_5 = create(:invoice, customer: spendy_customer, created_at: Date.new(2023,1,3))
      invoice_6 = create(:invoice, customer: spendy_customer)
      #merchant 5
      invoice_7 = create(:invoice, customer: spendy_customer, created_at: Date.new(2023,1,4))
      invoice_8 = create(:invoice, customer: spendy_customer, created_at: Date.new(2023,1,4))
      invoice_9 = create(:invoice, customer: spendy_customer)
      #merchant 2
      invoice_10 = create(:invoice, customer: spendy_customer, created_at: Date.new(2023,1,5))
      #merchant 4
      invoice_11 = create(:invoice, customer: spendy_customer, created_at: Date.new(2023,1,6))
      #merchant 6
      invoice_12 = create(:invoice, customer: spendy_customer, created_at: Date.new(2023,1,7))
      
      create(:transaction, invoice: invoice_1, result: 0)
      create(:transaction, invoice: invoice_2, result: 0)
      create(:transaction, invoice: invoice_3, result: 1)

      create(:transaction, invoice: invoice_4, result: 0)
      create(:transaction, invoice: invoice_5, result: 0)
      create(:transaction, invoice: invoice_6, result: 1)

      create(:transaction, invoice: invoice_7, result: 0)
      create(:transaction, invoice: invoice_8, result: 0)
      create(:transaction, invoice: invoice_9, result: 1)

      create(:transaction, invoice: invoice_10, result: 0)
      create(:transaction, invoice: invoice_11, result: 0)
      create(:transaction, invoice: invoice_12, result: 0)


      #merchant 3 - 1900000 revenue
      invoice_item_1 = create(:invoice_item, item: item_1, invoice: invoice_1, unit_price: 3, quantity: 300000)
      invoice_item_2 = create(:invoice_item, item: item_1, invoice: invoice_2, unit_price: 2, quantity: 500000)
      invoice_item_3 = create(:invoice_item, item: item_1, invoice: invoice_3, unit_price: 1, quantity: 5000000)

      #merchant 1 - 5000000 revenue
      invoice_item_4 = create(:invoice_item, item: item_2, invoice: invoice_4, unit_price: 2, quantity: 2000000)
      invoice_item_5 = create(:invoice_item, item: item_2, invoice: invoice_5, unit_price: 2, quantity: 500000)
      invoice_item_6 = create(:invoice_item, item: item_2, invoice: invoice_6, unit_price: 2, quantity: 50000000)

      #merchant 5 - 10000000 revenue
      invoice_item_7 = create(:invoice_item, item: item_3, invoice: invoice_7, unit_price: 3, quantity: 2500000)
      invoice_item_8 = create(:invoice_item, item: item_3, invoice: invoice_8, unit_price: 5, quantity: 500000)
      invoice_item_9 = create(:invoice_item, item: item_3, invoice: invoice_9, unit_price: 2, quantity: 500000000)

      #merchant 2 - 1000000 revenue
      invoice_item_10 = create(:invoice_item, item: item_4, invoice: invoice_10, unit_price: 1, quantity: 1000000)

      #merchant 4 - 1500000 revenue 
      invoice_item_11 = create(:invoice_item, item: item_5, invoice: invoice_11, unit_price: 1, quantity: 1500000)

      #merchant 6 - 500000 revenue
      invoice_item_12 = create(:invoice_item, item: item_6, invoice: invoice_12, unit_price: 1, quantity: 500000)

      visit admin_merchants_path
    end

    describe "User Story 30" do
      it "When I visit the admin merchants index, I see the names of the top 5 merchants by total revenue and
        I see that each merchant name links to the admin merchant show page for that merchant" do

        within("#top_merchant-#{@merchant_5.id}") { 
          expect(page).to have_content("#{@merchant_5.name} - $100,000 in sales") 
          expect(page).to have_link("#{@merchant_5.name}", href: admin_merchant_path(@merchant_5))
        }
        
        within("#top_merchant-#{@merchant_1.id}") { 
          expect(page).to have_content("#{@merchant_1.name} - $50,000 in sales") 
          expect(page).to have_link("#{@merchant_1.name}", href: admin_merchant_path(@merchant_1))          
        }
        
        within("#top_merchant-#{@merchant_3.id}") { 
          expect(page).to have_content("#{@merchant_3.name} - $19,000 in sales") 
          expect(page).to have_link("#{@merchant_3.name}", href: admin_merchant_path(@merchant_3))
        }

        within("#top_merchant-#{@merchant_4.id}") { 
          expect(page).to have_content("#{@merchant_4.name} - $15,000 in sales") 
          expect(page).to have_link("#{@merchant_4.name}", href: admin_merchant_path(@merchant_4))
        }

        within("#top_merchant-#{@merchant_2.id}") { 
          expect(page).to have_content("#{@merchant_2.name} - $10,000 in sales")
          expect(page).to have_link("#{@merchant_2.name}", href: admin_merchant_path(@merchant_2))
        }

        within("#top_merchants") {
          expect(@merchant_5.name).to appear_before(@merchant_1.name)
          expect(@merchant_1.name).to appear_before(@merchant_3.name)
          expect(@merchant_3.name).to appear_before(@merchant_4.name)
          expect(@merchant_4.name).to appear_before(@merchant_2.name)
        }
      end
    end

    describe "User Story 31" do
      it "When I visit the admin merchants index, next to each of the top merchnats, I see the date with the most revenue for each merchant. I see a label “Top selling date for <merchant name> was <date with most sales>" do

        within("#top_merchant-#{@merchant_5.id}") { 
          expect(page).to have_content("Top day for #{@merchant_5.name} was 1/4/23") 
        }
        
        within("#top_merchant-#{@merchant_1.id}") { 
          expect(page).to have_content("Top day for #{@merchant_1.name} was 1/2/23")     
        }
        
        within("#top_merchant-#{@merchant_3.id}") { 
          expect(page).to have_content("Top day for #{@merchant_3.name} was 1/1/23") 
        }

        within("#top_merchant-#{@merchant_4.id}") { 
          expect(page).to have_content("Top day for #{@merchant_4.name} was 1/6/23") 
        }

        within("#top_merchant-#{@merchant_2.id}") { 
          expect(page).to have_content("Top day for #{@merchant_2.name} was 1/5/23") 
        }
      end
    end
  end
end