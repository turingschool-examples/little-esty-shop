require 'rails_helper'

RSpec.describe 'admin dashboard' do
  before :each do
    visit '/admin'
  end
  
  describe 'as an admin visiting'
    it 'has as a header indicating I am on admin dashboard' do
      

      expect(page).to have_content("Admin Dashboard")
    end

  describe 'incomplete invoices section'
    it 'exists' do
      within("#incInvoices") do
        expect(page).to have_content("Incomplete Invoices")
      end
    end

  describe 'links'
    xit 'has a link to the Admin Merchant Index' do
      click_link("Merchant Index")
    end

    xit 'has a link to the Admin Invoice Index' do
      click_link("Invoice Index")
    end

  end