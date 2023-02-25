require 'rails_helper'

describe "As an admin" do
  let!(:merchant1) {Merchant.create!(name: "Brian's Beads")}

  let!(:customer1) { Customer.create!(first_name: "Britney", last_name: "Spears")}
  let!(:customer2) { Customer.create!(first_name: "Bob", last_name: "Smith")}
  let!(:customer3) { Customer.create!(first_name: "Bill", last_name: "Johnson")}
  let!(:customer4) { Customer.create!(first_name: "Boris", last_name: "Nelson")}
  let!(:customer5) { Customer.create!(first_name: "Barbara", last_name: "Hilton")}
  let!(:customer6) { Customer.create!(first_name: "Bella", last_name: "Thomas")}

  let!(:invoice1) { customer1.invoices.create!(status: 2, created_at: Date.new(2014, 3, 1)) }
  let!(:invoice2) { customer1.invoices.create!(status: 2, created_at: Date.new(2012, 2, 2)) }

  let!(:invoice3) { customer2.invoices.create!(status: 2) }
  let!(:invoice4) { customer2.invoices.create!(status: 2) }

  let!(:invoice5) { customer3.invoices.create!(status: 2) }
  let!(:invoice6) { customer3.invoices.create!(status: 2) }

  let!(:invoice7) { customer4.invoices.create!(status: 2) }

  let!(:invoice8) { customer5.invoices.create!(status: 2) }
  let!(:invoice9) { customer5.invoices.create!(status: 2) }
  
  let!(:invoice10) { customer6.invoices.create!(status: 2) }
  let!(:invoice11) { customer6.invoices.create!(status: 2) }

  let!(:item1) { merchant1.items.create!(name: "water bottle", description: "24oz metal container for water", unit_price: 8) }    
  let!(:item2) { merchant1.items.create!(name: "rubber duck", description: "toy for bath", unit_price: 1) }    
  let!(:item3) { merchant1.items.create!(name: "lamp", description: "12 inch desk lamp", unit_price: 16) }    
  let!(:item4) { merchant1.items.create!(name: "wireless mouse", description: "wireless computer mouse for mac", unit_price: 40) }    
  let!(:item5) { merchant1.items.create!(name: "chapstick", description: "coconut flavor chapstick", unit_price: 2) }
  
  let!(:transaction1) { invoice1.transactions.create!(credit_card_number: 4654405418249632, credit_card_expiration_date: Date.new(2024, 1, 3), result: "success") }
  let!(:transaction2) { invoice1.transactions.create!(credit_card_number: 4140149827486249, credit_card_expiration_date: Date.new(2024, 1, 3), result: "success") }
  
  let!(:transaction3) { invoice2.transactions.create!(credit_card_number: 4763141973880496, credit_card_expiration_date: Date.new(2024, 1, 3), result: "success") }
  let!(:transaction4) { invoice2.transactions.create!(credit_card_number: 4173081602435789, credit_card_expiration_date: Date.new(2024, 1, 3), result: "success") }
  let!(:transaction5) { invoice2.transactions.create!(credit_card_number: 4972246905754900, credit_card_expiration_date: Date.new(2024, 1, 3), result: "success") }
  
  let!(:transaction6) { invoice3.transactions.create!(credit_card_number: 4993984512460266, credit_card_expiration_date: Date.new(2024, 1, 3), result: "success") }
  let!(:transaction7) { invoice3.transactions.create!(credit_card_number: 4504301557459341, credit_card_expiration_date: Date.new(2024, 1, 3), result: "failed") }
  
  let!(:transaction8) { invoice4.transactions.create!(credit_card_number: 4504301557459341, credit_card_expiration_date: Date.new(2024, 1, 3), result: "failed") }
  
  let!(:transaction9) { invoice5.transactions.create!(credit_card_number: 4504301557459341, credit_card_expiration_date: Date.new(2024, 1, 3), result: "success") }
  
  let!(:transaction10) { invoice6.transactions.create!(credit_card_number: 4504301557459341, credit_card_expiration_date: Date.new(2024, 1, 3), result: "success") }
  let!(:transaction11) { invoice6.transactions.create!(credit_card_number: 4504301557459341, credit_card_expiration_date: Date.new(2024, 1, 3), result: "success") }
  let!(:transaction12) { invoice6.transactions.create!(credit_card_number: 4504301557459341, credit_card_expiration_date: Date.new(2024, 1, 3), result: "success") }
  
  let!(:transaction13) { invoice7.transactions.create!(credit_card_number: 4504301557459341, credit_card_expiration_date: Date.new(2024, 1, 3), result: "failed") }

  let!(:transaction14) { invoice8.transactions.create!(credit_card_number: 4504301557459341, credit_card_expiration_date: Date.new(2024, 1, 3), result: "success") }
  let!(:transaction15) { invoice8.transactions.create!(credit_card_number: 4504301557459341, credit_card_expiration_date: Date.new(2024, 1, 3), result: "success") }
  
  let!(:transaction16) { invoice9.transactions.create!(credit_card_number: 4504301557459341, credit_card_expiration_date: Date.new(2024, 1, 3), result: "success") }
  
  let!(:transaction17) { invoice10.transactions.create!(credit_card_number: 4504301557459341, credit_card_expiration_date: Date.new(2024, 1, 3), result: "success") }
  
  let!(:transaction18) { invoice11.transactions.create!(credit_card_number: 4504301557459341, credit_card_expiration_date: Date.new(2024, 1, 3), result: "failed") }
  let!(:transaction19) { invoice11.transactions.create!(credit_card_number: 4504301557459341, credit_card_expiration_date: Date.new(2024, 1, 3), result: "success") }

  before(:each) do
    InvoiceItem.create!(invoice_id: invoice1.id, item_id: item1.id, quantity: 3, unit_price: item1.unit_price, status: 0)
    InvoiceItem.create!(invoice_id: invoice2.id, item_id: item2.id, quantity: 7, unit_price: item2.unit_price, status: 1)
    InvoiceItem.create!(invoice_id: invoice2.id, item_id: item3.id, quantity: 1, unit_price: item3.unit_price, status: 2)
    InvoiceItem.create!(invoice_id: invoice3.id, item_id: item3.id, quantity: 6, unit_price: item3.unit_price, status: 2)
    InvoiceItem.create!(invoice_id: invoice4.id, item_id: item4.id, quantity: 9, unit_price: item4.unit_price, status: 1)
    InvoiceItem.create!(invoice_id: invoice5.id, item_id: item5.id, quantity: 4, unit_price: item5.unit_price, status: 0)
    InvoiceItem.create!(invoice_id: invoice5.id, item_id: item4.id, quantity: 7, unit_price: item4.unit_price, status: 0)
    InvoiceItem.create!(invoice_id: invoice6.id, item_id: item4.id, quantity: 8, unit_price: item4.unit_price, status: 2)
    InvoiceItem.create!(invoice_id: invoice7.id, item_id: item3.id, quantity: 6, unit_price: item3.unit_price, status: 1)
    InvoiceItem.create!(invoice_id: invoice8.id, item_id: item2.id, quantity: 3, unit_price: item2.unit_price, status: 0)
    InvoiceItem.create!(invoice_id: invoice9.id, item_id: item1.id, quantity: 2, unit_price: item1.unit_price, status: 2)
    InvoiceItem.create!(invoice_id: invoice10.id, item_id: item2.id, quantity: 1, unit_price: item2.unit_price, status: 1)
    InvoiceItem.create!(invoice_id: invoice10.id, item_id: item5.id, quantity: 3, unit_price: item5.unit_price, status: 0)
    InvoiceItem.create!(invoice_id: invoice11.id, item_id: item3.id, quantity: 2, unit_price: item3.unit_price, status: 0)
  end

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
        expect(page).to have_content("#{customer1.first_name} #{customer1.last_name} - 5 purchases") 
        expect(page).to have_content("#{customer3.first_name} #{customer3.last_name} - 4 purchases")
        expect(page).to have_content("#{customer5.first_name} #{customer5.last_name} - 3 purchases")
        expect(page).to have_content("#{customer6.first_name} #{customer6.last_name} - 2 purchases")
        expect(page).to have_content("#{customer2.first_name} #{customer2.last_name} - 1 purchases")
        expect(page).to_not have_content("#{customer4.first_name} #{customer4.last_name}")
      end
    end

    it "I see a section for 'Incomplete Invoices' that lists the ids, as links to their admin invoice show pages, of all invoices that have items that have not yet been shipped" do
      visit "/admin"

      within "#incomplete_invoices" do
        expect(page).to have_link("#{invoice1.id}", href: admin_invoice_path(invoice1.id))
        expect(page).to have_link("#{invoice2.id}", href: admin_invoice_path(invoice2.id))
        expect(page).to have_link("#{invoice4.id}", href: admin_invoice_path(invoice4.id))
        expect(page).to have_link("#{invoice5.id}", href: admin_invoice_path(invoice5.id))
        expect(page).to have_link("#{invoice7.id}", href: admin_invoice_path(invoice7.id))
        expect(page).to have_link("#{invoice8.id}", href: admin_invoice_path(invoice8.id))
        expect(page).to have_link("#{invoice10.id}", href: admin_invoice_path(invoice10.id))
        expect(page).to have_link("#{invoice11.id}", href: admin_invoice_path(invoice11.id))
        expect(page).to_not have_content("#{invoice3.id}")
        expect(page).to_not have_content("#{invoice6.id}")
        expect(page).to_not have_content("#{invoice9.id}")
      end
    end

    it "has links to each incomplete invoice's admin invoice show page" do
      visit "/admin"

      within "#incomplete_invoices" do
				click_link "#{invoice1.id}"
        expect(current_path).to eq("/admin/invoices/#{invoice1.id}")
      end
    end

    it "next to each invoice id I see the date that the invoice was created" do
      visit "/admin"

      within "#incomplete_invoices" do
        expect(page).to have_content("Invoice ##{invoice1.id} - #{invoice1.created_at.strftime("%A, %B %d, %Y")}")
        expect(page).to have_content("Invoice ##{invoice2.id} - #{invoice2.created_at.strftime("%A, %B %d, %Y")}")
        expect(page).to have_content("Invoice ##{invoice4.id} - #{invoice4.created_at.strftime("%A, %B %d, %Y")}")
        expect(page).to have_content("Invoice ##{invoice5.id} - #{invoice5.created_at.strftime("%A, %B %d, %Y")}")
        expect(page).to have_content("Invoice ##{invoice7.id} - #{invoice7.created_at.strftime("%A, %B %d, %Y")}")
        expect(page).to have_content("Invoice ##{invoice8.id} - #{invoice8.created_at.strftime("%A, %B %d, %Y")}")
        expect(page).to have_content("Invoice ##{invoice10.id} - #{invoice10.created_at.strftime("%A, %B %d, %Y")}")
        expect(page).to have_content("Invoice ##{invoice11.id} - #{invoice11.created_at.strftime("%A, %B %d, %Y")}")
      end
    end

    it "shows the invoice id and date ordered from oldest to newest" do
      visit "/admin"

      within "#incomplete_invoices" do
        expect("#{invoice2.id}").to appear_before("#{invoice1.id}")
        expect("#{invoice1.id}").to appear_before("#{invoice4.id}")
        expect("#{invoice4.id}").to appear_before("#{invoice5.id}")
        expect("#{invoice5.id}").to appear_before("#{invoice7.id}")
        expect("#{invoice7.id}").to appear_before("#{invoice8.id}")
        expect("#{invoice8.id}").to appear_before("#{invoice10.id}")
        expect("#{invoice10.id}").to appear_before("#{invoice11.id}")
      end
    end
  end
end