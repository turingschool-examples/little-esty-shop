require 'rails_helper'

RSpec.describe 'admin dashboard' do
  before :each do
    @customers = create_list(:customer, 8)
      
    @inv_0 = create(:invoice, customer: @customers[0], status: 1)
    @transacts_0 = create_list(:transaction, 15, invoice: @inv_0, result: 0)

    @inv_1 = create(:invoice, customer: @customers[1], status: 1)
    @transacts_1 = create_list(:transaction, 14, invoice: @inv_1, result: 0)

    @inv_2 = create(:invoice, customer: @customers[2], status: 1)
    @transacts_2 = create_list(:transaction, 13, invoice: @inv_2, result: 0)

    @inv_3 = create(:invoice, customer: @customers[3], status: 1)
    @transacts_3 = create_list(:transaction, 12, invoice: @inv_3, result: 0)

    @inv_4 = create(:invoice, customer: @customers[4], status: 1)
    @transacts_4 = create_list(:transaction, 11, invoice: @inv_4, result: 0)

    @inv_5 = create(:invoice, customer: @customers[5], status: 1)
    transacts_5 = create_list(:transaction, 10, invoice: @inv_5, result: 0)

    @inv_6 = create(:invoice, customer: @customers[6], status: 1)
    @transacts_6 = create_list(:transaction, 9, invoice: @inv_6, result: 0)
    @unsuc_transacts_6 = create_list(:transaction, 9, invoice: @inv_6, result: 1)

    @inv_7 = create(:invoice, customer: @customers[7], status: 1)
    @transacts_7 = create_list(:transaction, 8, invoice: @inv_7, result: 0)
    @unsuc_transacts_7 = create_list(:transaction, 8, invoice: @inv_7, result: 1)
    
    visit '/admin'
  end
  
  describe 'as an admin visiting'
    it 'has as a header indicating I am on admin dashboard' do
      expect(page).to have_content("Admin Dashboard")
    end

  describe 'top 5 customers section' do
    
    it 'exists' do
      within("#favorite_customers") do
        expect(page).to have_content("Top 5 Customers Overall")
      end
    end

    it 'has the names of the top 5 customers by successful transaction count' do
      within("#favorite_customers") do
        
        expect(page).to have_content(@customers[0].first_name)
        expect(page).to have_content(@customers[0].last_name)
        
        expect(page).to_not have_content(@customers[5].first_name)
        expect(page).to_not have_content(@customers[5].last_name)
      end
    end
    
    
    
    end

  describe 'incomplete invoices section'
    it 'exists' do
      within("#incInvoices") do
        expect(page).to have_content("Incomplete Invoices")
      end
    end

  describe 'links'
    it 'has a link to the Admin Merchant Index' do
      click_link("Merchant Index")
      expect(current_path).to eq(admin_merchants_path)
    end

    xit 'has a link to the Admin Invoice Index' do
      click_link("Invoice Index")
    end

  end