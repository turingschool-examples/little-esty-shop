require 'rails_helper'
require 'factory_bot'

RSpec.describe "the Admin Merchants page" do
    # before { visit '/admin' }
    # page.should render_template("layouts/admin")
    before :each do
        @merchant1 = FactoryBot.create(:merchant)
        @merchant2 = FactoryBot.create(:merchant)
      
        # @customer1 = FactoryBot.create(:customer)
        # @customer2 = FactoryBot.create(:customer)
        # @customer3 = FactoryBot.create(:customer)
        # @customer4 = FactoryBot.create(:customer)
        # @customer5 = FactoryBot.create(:customer)
        # @customer6 = FactoryBot.create(:customer)
        
        # FactoryBot.create_list(:invoice, 1, customer: @customer1, merchant: @merchant1)
        # FactoryBot.create_list(:invoice, 1, customer: @customer2, merchant: @merchant1)
        # FactoryBot.create_list(:invoice, 1, customer: @customer3, merchant: @merchant1)
        # FactoryBot.create_list(:invoice, 1, customer: @customer4, merchant: @merchant2)
        # FactoryBot.create_list(:invoice, 1, customer: @customer5, merchant: @merchant2)
        # FactoryBot.create_list(:invoice, 1, customer: @customer6, merchant: @merchant2)
    
        # FactoryBot.create_list(:transaction, 1, invoice: @customer1.invoices.first, result: 0)
        # FactoryBot.create_list(:transaction, 2, invoice: @customer2.invoices.first, result: 0)
        # FactoryBot.create_list(:transaction, 3, invoice: @customer3.invoices.first, result: 0)
        # FactoryBot.create_list(:transaction, 4, invoice: @customer4.invoices.first, result: 0)
        # FactoryBot.create_list(:transaction, 5, invoice: @customer5.invoices.first, result: 0)
        # FactoryBot.create_list(:transaction, 6, invoice: @customer6.invoices.first, result: 0)
        # # Customer.all.each do |customer|
        # #   transaction_count = [1..8].sample
        # #   FactoryBot.create_list(:transaction, transaction_count, invoice: customer.invoices.first, result: 1)
        # # end
    end
    it "should display the enabled and disabled merchants" do
        visit '/admin/merchants'

        within('#disabled-merchants') do 
            expect(all('.merchant-1').text).to eq("#{@merchant1.name}")
            expect(all('.merchant-2').text).to eq("#{@merchant2.name}")
        end
    end 

end