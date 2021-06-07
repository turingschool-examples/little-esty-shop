# require 'rails_helper'
#
# RSpec.describe Merchant, type: :feature do
#   describe "Merchant Dashboard" do
#     before :each do
#       @merchant_1 = Merchant.create!(name: "Regina's Ragin' Ragu")
#       @merchant_2 = Merchant.create!(name: "Mark's Money Makin' Markers")
#       @merchant_3 = Merchant.create!(name: "Caleb's California Catapults")
#       @item_1 = @merchant_1.items.create!(name: "Zesty Zucchini", description: "Yummy", unit_price: 400)
#       @item_2 = @merchant_1.items.create!(name: "Gnarly Garly", description: "Yum Yum Spicy", unit_price: 100)
#       @customer_1 = Customer.create!(first_name: "Me", last_name: "Last Name")
#       @invoice_1 = Invoice.create!(customer_id: @customer_1.id, status: "in progress")
#       InvoiceItem.create!(item_id: @item_1.id, invoice_id: @invoice_1.id, quantity: 1, unit_price: 400, status: "packaged")
#       InvoiceItem.create!(item_id: @item_2.id, invoice_id: @invoice_1.id, quantity: 2, unit_price: 200, status: "shipped")
#     end
#
#     it "should display name of merchant" do
#       visit "/merchants/#{@merchant_1.id}/dashboard"
#       expect(page).to have_content("#{@merchant_1.name}")
#       expect(page).to_not have_content("#{@merchant_2.name}")
#     end
#
#     it "should contain links to merchant items index and merchant invoices index" do
#       visit "/merchants/#{@merchant_1.id}/dashboard"
#       expect(page).to have_link("#{@merchant_1.name} Items Index")
#       click_link("#{@merchant_1.name} Items Index")
#       expect(current_path).to eq("/merchants/#{@merchant_1.id}/items")
#
#       visit "/merchants/#{@merchant_1.id}/dashboard"
#       expect(page).to have_link("#{@merchant_1.name} Invoices Index")
#       # click_link("#{@merchant_1.name} Invoices Index")
#       # expect(current_path).to eq("/merchants/#{@merchant_1.id}/invoices")
#     end
#
#     describe "should contain section for Items Ready to Ship" do
#       describe "and I see names of items ordered but not yet shipped" do
#         it "and invoice id next to each item is a link to merchant invoice show page" do
#       visit "/merchants/#{@merchant_1.id}/dashboard"
#       expect(page).to have_content("Items Ready to Ship")
#       #how to use within
#       expect(page).to have_content("#{@item_1.name}")
#       expect(page).to_not have_content("#{@item_2.name}")
#       # click_link("#{@invoice_1.id}")
#       # expect(page).to have_current_path("/merchants/#{@merchant_1.merchant_id}/invoices/#{@invoice_1.id}")
#         end
#       end
#     end
#
#   end
# end
