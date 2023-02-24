require 'rails_helper'

describe "As an admin" do
  let!(:customer1) { Customer.create!(uuid: 1, first_name: "Britney", last_name: "Spears")}
  let!(:customer2) { Customer.create!(uuid: 2, first_name: "Bob", last_name: "Smith")}
  let!(:customer3) { Customer.create!(uuid: 3, first_name: "Bill", last_name: "Johnson")}
  let!(:customer4) { Customer.create!(uuid: 4, first_name: "Boris", last_name: "Nelson")}
  let!(:customer5) { Customer.create!(uuid: 5, first_name: "Barbara", last_name: "Hilton")}
  let!(:customer6) { Customer.create!(uuid: 6, first_name: "Bella", last_name: "Thomas")}

  let!(:invoice1) { customer1.invoices.create!(uuid: 1, status: 2) }
  let!(:invoice2) { customer1.invoices.create!(uuid: 2, status: 2) }

  let!(:invoice3) { customer2.invoices.create!(uuid: 3, status: 2) }
  let!(:invoice4) { customer2.invoices.create!(uuid: 4, status: 2) }

  let!(:invoice5) { customer3.invoices.create!(uuid: 5, status: 2) }
  let!(:invoice6) { customer3.invoices.create!(uuid: 6, status: 2) }

  let!(:invoice7) { customer4.invoices.create!(uuid: 7, status: 2) }

  let!(:invoice8) { customer5.invoices.create!(uuid: 8, status: 2) }
  let!(:invoice9) { customer5.invoices.create!(uuid: 9, status: 2) }
  
  let!(:invoice10) { customer6.invoices.create!(uuid: 10, status: 2) }
  let!(:invoice11) { customer6.invoices.create!(uuid: 11, status: 2) }
  
  let!(:transaction1) { invoice1.transactions.create!(uuid: 1, credit_card_number: 4654405418249632, credit_card_expiration_date: Date.new(2024, 1, 3), result: "success") }
  let!(:transaction2) { invoice1.transactions.create!(uuid: 2, credit_card_number: 4140149827486249, credit_card_expiration_date: Date.new(2024, 1, 3), result: "success") }
  
  let!(:transaction3) { invoice2.transactions.create!(uuid: 3, credit_card_number: 4763141973880496, credit_card_expiration_date: Date.new(2024, 1, 3), result: "success") }
  let!(:transaction4) { invoice2.transactions.create!(uuid: 4, credit_card_number: 4173081602435789, credit_card_expiration_date: Date.new(2024, 1, 3), result: "success") }
  let!(:transaction5) { invoice2.transactions.create!(uuid: 5, credit_card_number: 4972246905754900, credit_card_expiration_date: Date.new(2024, 1, 3), result: "success") }
  
  let!(:transaction6) { invoice3.transactions.create!(uuid: 6, credit_card_number: 4993984512460266, credit_card_expiration_date: Date.new(2024, 1, 3), result: "success") }
  let!(:transaction7) { invoice3.transactions.create!(uuid: 7, credit_card_number: 4504301557459341, credit_card_expiration_date: Date.new(2024, 1, 3), result: "failed") }
  
  let!(:transaction8) { invoice4.transactions.create!(uuid: 8, credit_card_number: 4504301557459341, credit_card_expiration_date: Date.new(2024, 1, 3), result: "failed") }
  
  let!(:transaction9) { invoice5.transactions.create!(uuid: 9, credit_card_number: 4504301557459341, credit_card_expiration_date: Date.new(2024, 1, 3), result: "success") }
  
  let!(:transaction10) { invoice6.transactions.create!(uuid: 10, credit_card_number: 4504301557459341, credit_card_expiration_date: Date.new(2024, 1, 3), result: "success") }
  let!(:transaction11) { invoice6.transactions.create!(uuid: 11, credit_card_number: 4504301557459341, credit_card_expiration_date: Date.new(2024, 1, 3), result: "success") }
  let!(:transaction12) { invoice6.transactions.create!(uuid: 12, credit_card_number: 4504301557459341, credit_card_expiration_date: Date.new(2024, 1, 3), result: "success") }
  
  let!(:transaction13) { invoice7.transactions.create!(uuid: 13, credit_card_number: 4504301557459341, credit_card_expiration_date: Date.new(2024, 1, 3), result: "failed") }

  let!(:transaction14) { invoice8.transactions.create!(uuid: 14, credit_card_number: 4504301557459341, credit_card_expiration_date: Date.new(2024, 1, 3), result: "success") }
  let!(:transaction15) { invoice8.transactions.create!(uuid: 15, credit_card_number: 4504301557459341, credit_card_expiration_date: Date.new(2024, 1, 3), result: "success") }
  
  let!(:transaction16) { invoice9.transactions.create!(uuid: 16, credit_card_number: 4504301557459341, credit_card_expiration_date: Date.new(2024, 1, 3), result: "success") }
  
  let!(:transaction17) { invoice10.transactions.create!(uuid: 17, credit_card_number: 4504301557459341, credit_card_expiration_date: Date.new(2024, 1, 3), result: "success") }
  
  let!(:transaction18) { invoice11.transactions.create!(uuid: 18, credit_card_number: 4504301557459341, credit_card_expiration_date: Date.new(2024, 1, 3), result: "failed") }
  let!(:transaction19) { invoice11.transactions.create!(uuid: 19, credit_card_number: 4504301557459341, credit_card_expiration_date: Date.new(2024, 1, 3), result: "success") }

  describe "When I visit the admin dashboard" do
    it "I see a header indicating that I am on the admin dashboard" do
      visit "/admin"

      expect(page).to have_content("Admin Dashboard")
    end

    it "I see a link to the admin merchants index" do
      visit "/admin"

      expect(page).to have_link("Admin Merchants", href: admin_merchants_path)

      click_link "Admin Merchants"

      expect(current_path).to eq("/admin/merchants")
    end

    it "I see a link to the admin invoices index" do
      visit "/admin"

      expect(page).to have_link("Admin Invoices", href: admin_invoices_path)

      click_link "Admin Invoices"

      expect(current_path).to eq("/admin/invoices")
    end

    it "I see the names of the top 5 customers who have conducted the largest number of successful transactions and next to them, the number of successful transactions" do
      visit "/admin"

      within "#top_five_customers" do
        expect(page).to have_content("Name: #{customer1.first_name} #{customer1.last_name}, Successful Transactions: 5") 
        expect(page).to have_content("Name: #{customer3.first_name} #{customer3.last_name}, Successful Transactions: 4")
        expect(page).to have_content("Name: #{customer5.first_name} #{customer5.last_name}, Successful Transactions: 3")
        expect(page).to have_content("Name: #{customer6.first_name} #{customer6.last_name}, Successful Transactions: 2")
        expect(page).to have_content("Name: #{customer2.first_name} #{customer2.last_name}, Successful Transactions: 1")
        expect(page).to_not have_content("#{customer4.first_name} #{customer4.last_name}")
      end
    end
  end
end