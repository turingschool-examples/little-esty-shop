require 'rails_helper'
require 'factory_bot'

RSpec.describe "the Admin Dashboard" do
    # before { visit '/admin' }
    # page.should render_template("layouts/admin")
    before :each do
        @merchant = FactoryBot.create(:merchant)
      
        @customer1 = FactoryBot.create(:customer)
        @customer2 = FactoryBot.create(:customer)
        @customer3 = FactoryBot.create(:customer)
        @customer4 = FactoryBot.create(:customer)
        @customer5 = FactoryBot.create(:customer)
        @customer6 = FactoryBot.create(:customer)
        
        Customer.all.each do |customer|
            FactoryBot.create_list(:invoice, 1, customer: customer, merchant: @merchant)
        end
    
        FactoryBot.create_list(:transaction, 1, invoice: @customer1.invoices.first, result: 0)
        FactoryBot.create_list(:transaction, 2, invoice: @customer2.invoices.first, result: 0)
        FactoryBot.create_list(:transaction, 3, invoice: @customer3.invoices.first, result: 0)
        FactoryBot.create_list(:transaction, 4, invoice: @customer4.invoices.first, result: 0)
        FactoryBot.create_list(:transaction, 5, invoice: @customer5.invoices.first, result: 0)
        FactoryBot.create_list(:transaction, 6, invoice: @customer6.invoices.first, result: 0)
        # Customer.all.each do |customer|
        #   transaction_count = [1..8].sample
        #   FactoryBot.create_list(:transaction, transaction_count, invoice: customer.invoices.first, result: 1)
        # end
    end
    it "should display the project name, piulled from github api" do
        visit '/admin'

        within('header') do
            expect(page).to have_content("little-esty-shop")
        end

    end

    it "should display a header indicating you are on the admin dashboard" do
        visit '/admin'

        within('#topnav') do
            expect(page).to have_content("Admin Dashboard")
        end
    end

    
    it "header should have links to the admin, admin merchants, and admin invoices indexes" do
        visit '/admin'

        # find_link('Admin').visible?
        within('#topnav') do
            expect(page).to have_link("Dashboard")
            expect(page).to have_link("Merchants")
            expect(page).to have_link("Invoices")
        end
    end

    it "I see the names of the top 5 customers (no. transactions) names and number" do
        visit '/admin'

        within('#top-customers') do 
            expect(page).to have_content("Top Customers")
            expect(all('.customer')[0].text).to eq("#{@customer6.first_name} #{@customer6.last_name} - #{@customer6.successful_count} purchases")
        end
    end
end