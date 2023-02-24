require 'rails_helper'

RSpec.describe 'merchant show dashboard index page', type: :feature do
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
    
    


    # let!(:transaction1) {create(:transaction, invoice_id:) }
    let!(:transaction1) {create(:transaction, invoice: invoice1) }
    let!(:transaction1) {create(:transaction, invoice: invoice2) }
    let!(:transaction1) {create(:transaction, invoice: invoice3) }
    let!(:transaction1) {create(:transaction, invoice: invoice4) }
    let!(:transaction1) {create(:transaction, invoice: invoice5) }
    let!(:transaction1) {create(:transaction, invoice: invoice6) }
    let!(:transaction1) {create(:transaction, invoice: invoice7) }
    let!(:transaction1) {create(:transaction, invoice: invoice7) }
    let!(:transaction1) {create(:transaction, invoice: invoice8) }
    let!(:transaction1) {create(:transaction, invoice: invoice9) }
    let!(:transaction1) {create(:transaction, invoice: invoice10) }
    let!(:transaction1) {create(:transaction, invoice: invoice10) }
    let!(:transaction1) {create(:transaction, invoice: invoice11) }
    
    
    before do
      create(:invoice_item, invoice: invoice1)
      create(:invoice_item, invoice: invoice1)
      create(:invoice_item, invoice: invoice2)
      create(:invoice_item, invoice: invoice2)
      create(:invoice_item, invoice: invoice3)
      create(:invoice_item, invoice: invoice3)
      create(:invoice_item, invoice: invoice4)
      create(:invoice_item, invoice: invoice4)
      create(:invoice_item, invoice: invoice5)
      create(:invoice_item, invoice: invoice5)
      create(:invoice_item, invoice: invoice6)
      create(:invoice_item, invoice: invoice6)
      
      # InvoiceItem.create!(item: item2, invoice: invoice1)
      # InvoiceItem.create!(item: item1, invoice: invoice2)
      # InvoiceItem.create!(item: item4, invoice: invoice2)
      # InvoiceItem.create!(item: item4, invoice: invoice3)
      # InvoiceItem.create!(item: item3, invoice: invoice3)
      # InvoiceItem.create!(item: item1, invoice: invoice4)
      # InvoiceItem.create!(item: item4, invoice: invoice4)
      # InvoiceItem.create!(item: item1, invoice: invoice5)
      # InvoiceItem.create!(item: item2, invoice: invoice5)
      # InvoiceItem.create!(item: item2, invoice: invoice6)
      # InvoiceItem.create!(item: item3, invoice: invoice6)

      # InvoiceItem.create!(item: item5, invoice: invoice7)
      create(:invoice_item, item: item5, invoice: invoice7)

      # InvoiceItem.create!(item: item1, invoice: invoice8)
      # InvoiceItem.create!(item: item3, invoice: invoice8)
      # InvoiceItem.create!(item: item2, invoice: invoice9)
      # InvoiceItem.create!(item: item3, invoice: invoice9)
      # InvoiceItem.create!(item: item3, invoice: invoice10)
      # InvoiceItem.create!(item: item4, invoice: invoice10)
      # InvoiceItem.create!(item: item1, invoice: invoice11)
      # InvoiceItem.create!(item: item4, invoice: invoice11)
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

      expect(page).to have_content("Brian's Beads")
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

    it 'shows the names of the top 5 customers(largest number of successful transactions with merchant)' do
      visit "/merchants/#{merchant1.id}/dashboard"

      expect(page).to have_content("Top 5 customers with largest transactions")
      expect(page).to have_content("Britney Spears")
      expect(page).to have_content("Bob Smith")
      expect(page).to have_content("Bill Johnson")
      expect(page).to have_content("Barbara Hilton")
      expect(page).to have_content("Bella Thomas")
      expect(page).to_not have_content("Boris Nelson")
    end

    xit 'next to the top five customers, I see the number of successful transactions they have conducted with merchant' do
      visit "/merchants/#{merchant1.id}/dashboard"

    end
  end
end