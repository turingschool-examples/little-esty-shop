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

    customer1.invoices.create!(uuid: 10, status: 2)
    customer1.invoices.create!(uuid: 11, status: 2)

    customer2.invoices.create!(uuid: 12, status: 2)
    customer2.invoices.create!(uuid: 13, status: 2)

    customer3.invoices.create!(uuid: 14, status: 2)
    customer3.invoices.create!(uuid: 15, status: 2)

    customer4.invoices.create!(uuid: 16, status: 2)
    customer4.invoices.create!(uuid: 17, status: 2)
    customer4.invoices.create!(uuid: 18, status: 2)
    
    customer5.invoices.create!(uuid: 19, status: 2)
    customer5.invoices.create!(uuid: 20, status: 2)

    customer6.invoices.create!(uuid: 21, status: 2)
    customer6.invoices.create!(uuid: 22, status: 2)

    

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

    end

    it 'next to the top five customers, I see the number of successful transactions they have conducted with merchant' do

    end
  end
end