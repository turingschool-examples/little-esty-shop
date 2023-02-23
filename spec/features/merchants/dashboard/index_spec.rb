require 'rails_helper'

RSpec.describe 'merchant show dashboard index page', type: :feature do
  describe "as a merchant visiting '/merchants/merchant_id/dashboard'" do
    let!(:merchant1) {Merchant.create!(uuid: 101, name: "Brian's Beads")}

    let!(:customer1) { Customer.create!(uuid: 1, first_name: "Britney", last_name: "Spears")}
    let!(:customer2) { Customer.create!(uuid: 2, first_name: "Bob", last_name: "Smith")}
    let!(:customer3) { Customer.create!(uuid: 3, first_name: "Bill", last_name: "Johnson")}
    let!(:customer4) { Customer.create!(uuid: 4, first_name: "Boris", last_name: "Nelson")}
    let!(:customer5) { Customer.create!(uuid: 5, first_name: "Barbara", last_name: "Hilton")}
    let!(:customer6) { Customer.create!(uuid: 6, first_name: "Bella", last_name: "Thomas")}

    let!(:invoice1) { customer1.invoices.create!(uuid: 10, status: 2) }
    let!(:invoice2) { customer1.invoices.create!(uuid: 11, status: 2) }
    let!(:invoice3) { customer2.invoices.create!(uuid: 12, status: 2) }
    let!(:invoice4) { customer2.invoices.create!(uuid: 13, status: 2) }
    let!(:invoice5) { customer3.invoices.create!(uuid: 14, status: 2) }
    let!(:invoice6) { customer3.invoices.create!(uuid: 15, status: 2) }
    let!(:invoice7) { customer4.invoices.create!(uuid: 16, status: 2) }
    let!(:invoice8) { customer5.invoices.create!(uuid: 17, status: 2) }
    let!(:invoice9) { customer5.invoices.create!(uuid: 18, status: 2) }
    let!(:invoice10) { customer6.invoices.create!(uuid: 19, status: 2) }
    let!(:invoice11) { customer6.invoices.create!(uuid: 20, status: 2) }

    let!(:item1) { merchant1.items.create!(name: "water bottle", description: "24oz metal container for water", unit_price: 8) }    
    let!(:item2) { merchant1.items.create!(name: "rubber duck", description: "toy for bath", unit_price: 1) }    
    let!(:item3) { merchant1.items.create!(name: "lamp", description: "12 inch desk lamp", unit_price: 16) }    
    let!(:item4) { merchant1.items.create!(name: "wireless mouse", description: "wireless computer mouse for mac", unit_price: 40) }    
    let!(:item5) { merchant1.items.create!(name: "chapstick", description: "coconut flavor chapstick", unit_price: 2) }    

    before do
      InvoiceItem.create!(item: item1, invoice: invoice1)
      InvoiceItem.create!(item: item2, invoice: invoice1)
      InvoiceItem.create!(item: item1, invoice: invoice2)
      InvoiceItem.create!(item: item4, invoice: invoice2)
      InvoiceItem.create!(item: item4, invoice: invoice3)
      InvoiceItem.create!(item: item3, invoice: invoice3)
      InvoiceItem.create!(item: item1, invoice: invoice4)
      InvoiceItem.create!(item: item4, invoice: invoice4)
      InvoiceItem.create!(item: item1, invoice: invoice5)
      InvoiceItem.create!(item: item2, invoice: invoice5)
      InvoiceItem.create!(item: item2, invoice: invoice6)
      InvoiceItem.create!(item: item3, invoice: invoice6)

      InvoiceItem.create!(item: item5, invoice: invoice7)

      InvoiceItem.create!(item: item1, invoice: invoice8)
      InvoiceItem.create!(item: item3, invoice: invoice8)
      InvoiceItem.create!(item: item2, invoice: invoice9)
      InvoiceItem.create!(item: item3, invoice: invoice9)
      InvoiceItem.create!(item: item3, invoice: invoice10)
      InvoiceItem.create!(item: item4, invoice: invoice10)
      InvoiceItem.create!(item: item1, invoice: invoice11)
      InvoiceItem.create!(item: item4, invoice: invoice11)
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