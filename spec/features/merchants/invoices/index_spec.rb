require 'rails_helper'

RSpec.describe "merchant's invoices index  page", type: :feature do
  describe "as a merchant visiting '/merchants/merchant_id/invoices'" do
    let!(:merchant1) { create(:merchant)}
    let!(:merchant2) { create(:merchant)}

    let!(:customer1) { create(:customer)}
    let!(:customer2) { create(:customer)}
    let!(:customer3) { create(:customer)}

    let!(:invoice1) { create(:completed_invoice, customer: customer1)}
    let!(:invoice2) { create(:completed_invoice, customer: customer1)}
    let!(:invoice3) { create(:completed_invoice, customer: customer2)} 
    let!(:invoice4) { create(:completed_invoice, customer: customer2)}
    let!(:invoice5) { create(:completed_invoice, customer: customer3)}

    let!(:item1) {create(:item, merchant: merchant1)}  
    let!(:item2) {create(:item, merchant: merchant1)}
    let!(:item3) {create(:item, merchant: merchant1)}
    let!(:item4) {create(:item, merchant: merchant2)}
    
    before (:each) do
      create(:invoice_item, item: item1, invoice: invoice1)
      create(:invoice_item, item: item2, invoice: invoice2)
      create(:invoice_item, item: item3, invoice: invoice3)
      create(:invoice_item, item: item3, invoice: invoice4)
      create(:invoice_item, item: item4, invoice: invoice5)
    end
  
    
    it "I see all of the invoices that include at least one of my merchant's items, including id and link to merchant invoice show page" do
      visit "/merchants/#{merchant1.id}/invoices"

      expect(page).to have_content(invoice1.id, count: 1)
      expect(page).to have_link("#{invoice1.id}")
    
      expect(page).to have_content(invoice2.id, count: 1)
      expect(page).to have_link("#{invoice2.id}")

      expect(page).to have_content(invoice3.id, count: 1)
      expect(page).to have_link("#{invoice3.id}")

      expect(page).to have_content(invoice4.id, count: 1)
      expect(page).to have_link("#{invoice4.id}")

      expect(page).to_not have_content(invoice5.id)
      expect(page).to_not have_link("#{invoice5.id}")

      click_on "#{invoice1.id}"

      expect(current_path).to eq("/merchants/#{merchant1.id}/invoices/#{invoice1.id}")
    end
  end
end