require 'rails_helper'

RSpec.describe 'admin dashboard' do
  before :each do
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