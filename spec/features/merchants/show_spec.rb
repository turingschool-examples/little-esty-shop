require 'rails_helper'

RSpec.describe 'merchant show dashboard page', type: :feature do
  describe "as a merchant visiting '/merchants/merchant_id/dashboard'" do
    let!(:merchant1) { create(:merchant)}

    let!(:customer1) { create(:customer)}
    let!(:customer2) { create(:customer)}
    let!(:customer3) { create(:customer)}
    let!(:customer4) { create(:customer)}
    let!(:customer5) { create(:customer)}
    let!(:customer6) { create(:customer)}
  

    let!(:invoice1) { create(:completed_invoice, customer: customer1)}
    let!(:invoice2) { create(:completed_invoice, customer: customer1)}
    let!(:invoice3) { create(:completed_invoice, customer: customer2)} 
    let!(:invoice4) { create(:completed_invoice, customer: customer2)}
    let!(:invoice5) { create(:completed_invoice, customer: customer3)}
    let!(:invoice6) { create(:completed_invoice, customer: customer3)}
    let!(:invoice7) { create(:completed_invoice, customer: customer4)}
    let!(:invoice8) { create(:completed_invoice, customer: customer5)}
    let!(:invoice9) { create(:completed_invoice, customer: customer5)}
    let!(:invoice10) { create(:completed_invoice, customer: customer6)}
    let!(:invoice11) { create(:completed_invoice, customer: customer6)}

    let!(:item1) {create(:item, merchant: merchant1)}  
    let!(:item2) {create(:item, merchant: merchant1)}
    let!(:item3) {create(:item, merchant: merchant1)}
    let!(:item4) {create(:item, merchant: merchant1)}
    let!(:item5) {create(:item, merchant: merchant1)}
   
    let!(:transaction1) {create(:transaction, invoice: invoice1) }
    let!(:transaction2) {create(:transaction, invoice: invoice2) }
    let!(:transaction3) {create(:transaction, invoice: invoice3) }
    let!(:transaction4) {create(:transaction, invoice: invoice4) }
    let!(:transaction5) {create(:transaction, invoice: invoice5) }
    let!(:transaction6) {create(:transaction, invoice: invoice6) }
    let!(:transaction8) {create(:transaction, invoice: invoice7) }
    let!(:transaction9) {create(:transaction, invoice: invoice8) }
    let!(:transaction10) {create(:transaction, invoice: invoice9) }
    let!(:transaction11) {create(:transaction, invoice: invoice10) }
    let!(:transaction12) {create(:transaction, invoice: invoice10) }
    let!(:transaction13) {create(:transaction, invoice: invoice11) }
    
    before do
      create(:invoice_item, item: item1, invoice: invoice1)
      create(:invoice_item, item: item2, invoice: invoice1)
      create(:invoice_item, item: item1, invoice: invoice2)
      create(:invoice_item, item: item4, invoice: invoice2)
      create(:invoice_item, item: item4, invoice: invoice3)
      create(:invoice_item, item: item3, invoice: invoice3)
      create(:invoice_item, item: item1, invoice: invoice4)
      create(:invoice_item, item: item4, invoice: invoice4)
      create(:invoice_item, item: item1, invoice: invoice5)
      create(:invoice_item, item: item2, invoice: invoice5)
      create(:invoice_item, item: item2, invoice: invoice6)
      create(:invoice_item, item: item3, invoice: invoice6)
      
      create(:invoice_item, item: item5, invoice: invoice7)

      create(:invoice_item, item: item1, invoice: invoice8)
      create(:invoice_item, item: item3, invoice: invoice8)
      create(:invoice_item, item: item2, invoice: invoice9)
      create(:invoice_item, item: item3, invoice: invoice9)
      create(:invoice_item, item: item3, invoice: invoice10)
      create(:invoice_item, item: item4, invoice: invoice10)
      create(:invoice_item, item: item1, invoice: invoice11)
      create(:invoice_item, item: item4, invoice: invoice11)

    end
    

    it 'shows my name(merchant)' do
      visit "/merchants/#{merchant1.id}/dashboard"

      expect(page).to have_content("#{merchant1.name}")
    end

    it "will have a link that takes me to the 'merchants/merchant_id/items index page" do 

      visit "/merchants/#{merchant1.id}/dashboard"

      expect(page).to have_link("Merchant Items")

      click_link("Merchant Items")

      expect(current_path).to eq("/merchants/#{merchant1.id}/items")
    end

    it "will have a link that takes me to the 'merchants/merchant_id/invoices index page" do 

      visit "/merchants/#{merchant1.id}/dashboard"

      expect(page).to have_link("Merchant Invoices")

      click_link("Merchant Invoices")

      expect(current_path).to eq("/merchants/#{merchant1.id}/invoices")
    end 

    it 'shows the names of the top 5 customers(largest number of successful transactions with merchant) and the number of transactions conducted with merchant' do
      visit "/merchants/#{merchant1.id}/dashboard"
      
      save_and_open_page
      
      expect(page).to have_content("Top 5 customers with largest transactions")
      expect(page).to have_content("#{customer1.first_name} #{customer1.last_name}- number of transactions: #{merchant1.customer_successful_transactions(customer1.id)}")
      expect(page).to have_content("#{customer2.first_name} #{customer2.last_name}- number of transactions: #{merchant1.customer_successful_transactions(customer2.id)}")
      expect(page).to have_content("#{customer3.first_name} #{customer3.last_name}- number of transactions: #{merchant1.customer_successful_transactions(customer3.id)}")
      expect(page).to have_content("#{customer5.first_name} #{customer5.last_name}- number of transactions: #{merchant1.customer_successful_transactions(customer5.id)}")
      expect(page).to have_content("#{customer6.first_name} #{customer6.last_name}- number of transactions: #{merchant1.customer_successful_transactions(customer6.id)}")
      expect(page).to_not have_content("#{customer4.first_name} #{customer4.last_name}")
    end
  end
end