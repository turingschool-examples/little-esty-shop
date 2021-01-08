require 'rails_helper'
require 'factory_bot'

RSpec.describe "the Admin Dashboard" do
    # before { visit '/admin' }
    # page.should render_template("layouts/admin")
    before :each do
        @merchant = FactoryBot.create(:merchant)
  
        @customer_1 = FactoryBot.create(:customer)
        @customer_2 = FactoryBot.create(:customer)
        @customer_3 = FactoryBot.create(:customer)
        @customer_4 = FactoryBot.create(:customer)
        @customer_5 = FactoryBot.create(:customer)
        @customer_6 = FactoryBot.create(:customer)
        
        Customer.all.each do |customer|
            FactoryBot.create_list(:invoice, 1, customer: customer, merchant: @merchant)
        end
  
        customers = [@customer_1, @customer_2, @customer_3, @customer_4, @customer_5, @customer_6]
  
        customers.size.times do |i|
            FactoryBot.create_list(:transaction, (i+1), invoice: customers[i].invoices.first, result: 1)
        end
    end

    it "should display a header indicating you are on the admin dashboard" do
        visit '/admin'

        within('#header') do
            expect(page).to have_content("Admin Dashboard")
        end
    end

    it "header should have links to the admin, admin merchants, and admin invoices indexes" do
        visit '/admin'

        # find_link('Admin').visible?
        within('#header') do
            expect(page).to have_link("Admin")
            expect(page).to have_link("Merchants")
            expect(page).to have_link("Invoices")
        end
    end

    it "I see the names of the top 5 customers (no. transactions) names and number" do
        visit '/admin'

        within('#top-customers') do 
            expect(page).to have_content("Top Customers")
            expect(all('.customer')[0].text).to eq("#{@customer_6.first_name} #{@customer_6.last_name} - #{@customer_6.successful_count} purchases")
        end
    end
end