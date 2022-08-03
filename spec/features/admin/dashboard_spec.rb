require 'rails_helper'

RSpec.describe 'Admin Dashboard', type: :feature do 

 it "has a header indicating this is the admin dashboard" do 

  visit '/admin'

  expect(page).to have_content('Admin Dashboard')
 end

 it "has links to the admin merchants and invoices indexes" do 

  visit '/admin'

  expect(page).to have_link('Admin Merchants Index')
  expect(page).to have_link('Admin Invoices Index')
 end

# As an admin,
# When I visit the admin dashboard
# Then I see a section for "Incomplete Invoices"
# In that section I see a list of the ids of all invoices
# That have items that have not yet been shipped
# And each invoice id links to that invoice's admin show page

 it "can list incomplete invoices and link to the invoice's admin show page" do 
    merchant1 = Merchant.create!(name: "Poke Retirement homes", status: "enabled")
    merchant2 = Merchant.create!(name: "Rendolyn Guizs poke stops", status: "enabled")
    merchant3 = Merchant.create!(name: "Dhirley Secasrio's knits and bits", status: "enabled")

    item1 = Item.create!(name: "Pikachu pics", description: 'Cute pics with pikachu', unit_price: 1000, merchant_id: merchant1.id)
    item2 = Item.create!(name: "Pokemon stuffy", description: 'Pikachu stuffed toy', unit_price: 2000, merchant_id: merchant1.id)
    item3 = Item.create!(name: "Junk", description: 'junk you should want', unit_price: 500, merchant_id: merchant2.id)
    item4 = Item.create!(name: "Pencil", description: 'Writes things down', unit_price: 100, merchant_id: merchant2.id)
    item5 = Item.create!(name: "Chair", description: 'To sit on', unit_price: 7500, merchant_id: merchant2.id)
    item6 = Item.create!(name: "Blanket", description: 'Keeps you warm', unit_price: 2500, merchant_id: merchant3.id)
    item7 = Item.create!(name: "shoe", description: 'leather', unit_price: 3500, merchant_id: merchant3.id)

    customer1 = Customer.create!(first_name: "Parker", last_name: "Thomson")
    invoice1 = Invoice.create!(status: "completed", customer_id: customer1.id)
    invoice2 = Invoice.create!(status: "completed", customer_id: customer1.id)
    invoice3 = Invoice.create!(status: "completed", customer_id: customer1.id)
    invoice4 = Invoice.create!(status: "completed", customer_id: customer1.id)
    invoice5 = Invoice.create!(status: "completed", customer_id: customer1.id)
    invoice6 = Invoice.create!(status: "completed", customer_id: customer1.id)
    invoice7 = Invoice.create!(status: "completed", customer_id: customer1.id)
    invoice8 = Invoice.create!(status: "completed", customer_id: customer1.id)

    invoice_item1 = InvoiceItem.create!(quantity: 1, unit_price: item1.unit_price, status: "packaged", item_id: item1.id, invoice_id: invoice1.id)
    invoice_item2 = InvoiceItem.create!(quantity: 1, unit_price: item2.unit_price, status: "packaged", item_id: item2.id, invoice_id: invoice2.id)
    invoice_item3 = InvoiceItem.create!(quantity: 1, unit_price: item3.unit_price, status: "pending", item_id: item3.id, invoice_id: invoice3.id)
    invoice_item4 = InvoiceItem.create!(quantity: 1, unit_price: item4.unit_price, status: "pending", item_id: item4.id, invoice_id: invoice4.id)
    invoice_item5 = InvoiceItem.create!(quantity: 1, unit_price: item5.unit_price, status: "pending", item_id: item5.id, invoice_id: invoice5.id)
    invoice_item6 = InvoiceItem.create!(quantity: 1, unit_price: item6.unit_price, status: "packaged", item_id: item6.id, invoice_id: invoice6.id)
    invoice_item7 = InvoiceItem.create!(quantity: 1, unit_price: item7.unit_price, status: "shipped", item_id: item7.id, invoice_id: invoice7.id)
    invoice_item8 = InvoiceItem.create!(quantity: 1, unit_price: item1.unit_price, status: "shipped", item_id: item7.id, invoice_id: invoice8.id)
      
    visit '/admin'
    expect(page).to have_content("Incomplete Invoices")

    within '#incomplete_invoices' do
      expect(page).to have_content("#{invoice1.id}")
      expect(page).to have_content("#{invoice2.id}")
      expect(page).to have_content("#{invoice3.id}")
      expect(page).to have_content("#{invoice4.id}")
      expect(page).to have_content("#{invoice5.id}")
      expect(page).to have_content("#{invoice6.id}")

      expect(page).to_not have_content("#{invoice7.id}")
      expect(page).to_not have_content("#{invoice8.id}")
    
      expect(page).to have_link("#{invoice2.id}")
      click_on("#{invoice2.id}")
      expect(current_path).to eq("/admin/invoices/#{invoice2.id}")
    end
  end
end