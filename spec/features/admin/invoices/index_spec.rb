require 'rails_helper'

RSpec.describe "admin's invoices index  page", type: :feature do
  describe "as an admin visiting '/admin/invoices'" do
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

    it "Then I see a list of all Invoice ids in the system and each id links to the admin invoice show page" do
      visit "/admin/invoices"
      
      expect(page).to have_content(invoice1.id)
      expect(page).to have_link("#{invoice1.id}")
    
      expect(page).to have_content(invoice2.id)
      expect(page).to have_link("#{invoice2.id}")

      expect(page).to have_content(invoice3.id)
      expect(page).to have_link("#{invoice3.id}")

      expect(page).to have_content(invoice4.id)
      expect(page).to have_link("#{invoice4.id}")

      expect(page).to have_content(invoice5.id)
      expect(page).to have_link("#{invoice5.id}")

      click_on "#{invoice1.id}"

      expect(current_path).to eq("/admin/invoices/#{invoice1.id}")
    end
  end
end