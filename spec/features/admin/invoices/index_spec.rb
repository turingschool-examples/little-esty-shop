require 'rails_helper'

RSpec.describe 'admin invoices index page' do
  let!(:merchant) {Merchant.create!(name: "Parker")}
  let!(:merchant2) {Merchant.create!(name: "Joel")}
  let!(:merchant3) {Merchant.create!(name: "Kerri")}
  let!(:merchant4) {Merchant.create!(name: "John")}

  let!(:item) {merchant.items.create!(name: "Small Thing", description: "Its a thing that is small.", unit_price: 400)}
  let!(:item2) {merchant.items.create!(name: "Large Thing", description: "Its a thing that is large.", unit_price: 800)}
  let!(:item3) {merchant2.items.create!(name: "Medium Thing", description: "Its a thing that is medium.", unit_price: 600)}
  let!(:item4) {merchant2.items.create!(name: "Extra Large Thing", description: "Its a thing that is extra large.", unit_price: 1000)}
  let!(:item5) {merchant3.items.create!(name: "Tiny Thing", description: "Its a thing that is tiny.", unit_price: 200)}
  let!(:item6) {merchant3.items.create!(name: "Huge Thing", description: "Its a thing that is huge.", unit_price: 1200)}
  let!(:item7) {merchant4.items.create!(name: "Teensy Thing", description: "Its a thing that is teensy.", unit_price: 100)}
  let!(:item8) {merchant4.items.create!(name: "Gargantuan Thing", description: "Its a thing that is gargantuan.", unit_price: 1400)}

  let!(:customer) {Customer.create!(first_name: "Fred", last_name: "Rogers")}
  let!(:customer2) {Customer.create!(first_name: "Big", last_name: "Bird")}
  let!(:customer3) {Customer.create!(first_name: "Cookie", last_name: "Monster")}
  let!(:customer4) {Customer.create!(first_name: "George", last_name: "Jetson")}

  let!(:invoice) {customer.invoices.create!(status: "in progress")}
  let!(:invoice2) {customer2.invoices.create!(status: "in progress")}
  let!(:invoice3) {customer3.invoices.create!(status: "in progress")}
  let!(:invoice4) {customer4.invoices.create!(status: "in progress")}

  item.invoices.create!()

  # before(:each) do
  #   InvoiceItem.create!(invoice_id: invoice.id, item_id: item.id, quantity: 20, unit_price: 400, status: "pending")
  #   InvoiceItem.create!(invoice_id: invoice.id, item_id: item6.id, quantity: 6, unit_price: 1200, status: "pending")
  #   InvoiceItem.create!(invoice_id: invoice2.id, item_id: item2.id, quantity: 10, unit_price: 800, status: "pending")
  #   InvoiceItem.create!(invoice_id: invoice2.id, item_id: item3.id, quantity: 7, unit_price: 600, status: "pending")
  #   InvoiceItem.create!(invoice_id: invoice3.id, item_id: item4.id, quantity: 4, unit_price: 1000, status: "pending")
  #   InvoiceItem.create!(invoice_id: invoice4.id, item_id: item7.id, quantity: 50, unit_price: 100, status: "pending")
  #
  # end

  it 'shows all transaction ids' do
    visit "/admin/invoices/"
    expect(page).to have_content(invoice.id)
    expect(page).to have_content(invoice2.id)
    expect(page).to have_content(invoice3.id)
    expect(page).to have_content(invoice4.id)
  end

  it 'links to each transaction show page' do
    visit "/admin/invoices/"
    within("#admin-invoice-#{invoice.id}") do
      click_link("#{invoice.id}")
      expect(current_path).to eq("/admin/invoices/#{invoice.id}")
    end
    within("#admin-invoice-#{invoice2.id}") do
      click_link("#{invoice2.id}")
      expect(current_path).to eq("/admin/invoices/#{invoice2.id}")
    end
    # within("#admin-invoice-#{@invoice3.id}") do
    #   click_link("#{@invoice3.id}")
    #   expect(current_path).to eq("/admin/invoices/#{@invoice3.id}")
    # end
    # within("#admin-invoice-#{@invoice4.id}") do
    #   click_link("#{@invoice4.id}")
    #   expect(current_path).to eq("/admin/invoices/#{@invoice4.id}")
    # end
  end
end
