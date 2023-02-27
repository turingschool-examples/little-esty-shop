require 'rails_helper'

describe 'As a merchant', type: :feature do
  let!(:merchant1) { create(:merchant)}

  let!(:item1) {create(:item, merchant: merchant1)}  
  let!(:item2) {create(:item, merchant: merchant1)}
  let!(:item3) {create(:item, merchant: merchant1)}
  let!(:item4) {create(:item, merchant: merchant1)}
  let!(:item5) {create(:item, merchant: merchant1)}

  let!(:customer1) {create(:customer)}
  let!(:customer2) {create(:customer)}

  let!(:invoice1) {create(:invoice, created_at: Date.new(2020, 1, 2), customer: customer1)}
  let!(:invoice2) {create(:invoice, created_at: Date.new(2019, 3, 9), customer: customer2)}

  let!(:invoice_item1) { create(:invoice_item, invoice: invoice1, item: item1) }
  let!(:invoice_item2) { create(:invoice_item, invoice: invoice2, item: item2) }
  let!(:invoice_item3) { create(:invoice_item, invoice: invoice1, item: item3) }
  let!(:invoice_item4) { create(:invoice_item, invoice: invoice1, item: item4) }
  let!(:invoice_item5) { create(:invoice_item, invoice: invoice1, item: item5) }

  
  describe "When I visit an admin invoice show page" do
    it 'I see the invoice ID, status, and created_at date with formatting' do
      visit "/admin/invoices/#{invoice1.id}"

      expect(page).to have_content("Invoice ##{invoice1.id}")
      expect(page).to_not have_content(invoice2.id)
      expect(page).to have_select('Status', :selected=> "#{invoice1.status}")
      expect(page).to have_content("Created on: #{invoice1.created_at.strftime("%A, %B %d, %Y")}")
    end

    it "I see the customers first and last name" do
      visit "/admin/invoices/#{invoice1.id}"

      within "#customers" do
        expect(page).to have_content(customer1.first_name)
        expect(page).to have_content(customer1.last_name)
      end
    end

    it "I see all of the items on the invoice, including their name, quantity, price, and status" do
      visit "/admin/invoices/#{invoice1.id}"

      expect(page).to_not have_content(item2.name)

      within "##{item1.name}" do
        expect(page).to have_content("Item Name: #{item1.name}")
        expect(page).to have_content("Quantity: #{invoice_item1.quantity}")
        expect(page).to have_content("Unit Price: $#{invoice_item1.unit_price.to_f/100}")
        expect(page).to have_content("Status: #{invoice_item1.status}")
      end

      within "##{item3.name}" do
        expect(page).to have_content("Item Name: #{item3.name}")
        expect(page).to have_content("Quantity: #{invoice_item3.quantity}")
        expect(page).to have_content("Unit Price: $#{invoice_item3.unit_price.to_f/100}")
        expect(page).to have_content("Status: #{invoice_item3.status}")
      end

      within "##{item4.name}" do
        expect(page).to have_content("Item Name: #{item4.name}")
        expect(page).to have_content("Quantity: #{invoice_item4.quantity}")
        expect(page).to have_content("Unit Price: $#{invoice_item4.unit_price.to_f/100}")
        expect(page).to have_content("Status: #{invoice_item4.status}")
      end

      within "##{item5.name}" do
        expect(page).to have_content("Item Name: #{item5.name}")
        expect(page).to have_content("Quantity: #{invoice_item5.quantity}")
        expect(page).to have_content("Unit Price: $#{invoice_item5.unit_price.to_f/100}")
        expect(page).to have_content("Status: #{invoice_item5.status}")
      end
    end

    it "I see the invoice status is a select field and next to the select field I see a button to 'Update Invoice Status'" do
      visit "/admin/invoices/#{invoice1.id}"

      expect(page).to have_select('Status', :selected=> "#{invoice1.status}")
      expect(page).to have_button("Update Invoice Status")
    end

    it "When I select a new status for the Invoice and click the button, I am taken back to the admin invoice show page" do
      visit "/admin/invoices/#{invoice1.id}"

      select 'cancelled', from: :invoice_status
      click_button 'Update Invoice Status'

      expect(current_path).to eq(admin_invoice_path(invoice1))
    end

    it "When I select a new status and click the button, I see that my invoice's status has now been updated" do
      visit "/admin/invoices/#{invoice1.id}"

      select 'cancelled', from: :invoice_status
      click_button 'Update Invoice Status'

      expect(page).to have_select('Status', :selected=> "cancelled")
    end
  end
end