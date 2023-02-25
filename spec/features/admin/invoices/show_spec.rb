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

  before(:each) do
    create(:invoice_item, invoice: invoice1, item: item1)
    create(:invoice_item, invoice: invoice1, item: item2)
    create(:invoice_item, invoice: invoice1, item: item3)
    create(:invoice_item, invoice: invoice1, item: item4)
    create(:invoice_item, invoice: invoice2, item: item5)
  end
  
  describe "When I visit an admin invoice show page" do
    it 'I see the invoice ID, status, and created_at date with formatting' do
      visit "/admin/invoices/#{invoice1.id}"

      expect(page).to have_content("Invoice ##{invoice1.id}")
      expect(page).to_not have_content(invoice2.id)
      expect(page).to have_content("Status: #{invoice1.status}")
      expect(page).to have_content("Created on: #{invoice1.created_at.strftime("%A, %B %d, %Y")}")
    end

    it "I see the customers first and last name" do
      visit "/admin/invoices/#{invoice1.id}"

      within "#customers" do
        expect(page).to have_content(customer1.first_name)
        expect(page).to have_content(customer1.last_name)
      end
    end
  end
end