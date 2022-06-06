require 'rails_helper'

# Admin Merchants Index
#
# As an admin,
# When I visit the admin merchants index (/admin/merchants)
# Then I see the name of each merchant in the system

RSpec.describe "Admin Merchants Index Page ", type: :feature do
  # let!(:merchant1) { create(:merchant, status: 0) }
  # let!(:merchant2) { create(:merchant, status: 1) }
  # let!(:merchant3) { create(:merchant, status: 0) }
  # let!(:merchant4) { create(:merchant, status: 1) }
  # let!(:merchants) { create_list(:merchant, 2) }

  let!(:merchants)  { create_list(:merchant, 6, status: 1) }
  let!(:merchants2) { create_list(:merchant, 2, status: 0)}
  let!(:customer) { create(:customer) }

  let!(:item1) { create(:item, merchant: merchants[0], status: 1) }
  let!(:item2) { create(:item, merchant: merchants[1], status: 1) }
  let!(:item3) { create(:item, merchant: merchants[2], status: 1) }
  let!(:item4) { create(:item, merchant: merchants[3], status: 1) }
  let!(:item5) { create(:item, merchant: merchants[4], status: 1) }
  let!(:item6) { create(:item, merchant: merchants[5], status: 1) }

  let!(:invoice1) { create(:invoice, customer: customer, created_at: "2012-03-10 00:54:09 UTC") }
  let!(:invoice2) { create(:invoice, customer: customer, created_at: "2013-03-10 00:54:09 UTC") }
  let!(:invoice3) { create(:invoice, customer: customer, created_at: "2014-03-10 00:54:09 UTC") }
  
  let!(:transaction1) { create(:transaction, invoice: invoice1, result: 0) }
  let!(:transaction2) { create(:transaction, invoice: invoice1, result: 0) }
  let!(:transaction3) { create(:transaction, invoice: invoice2, result: 1) }
  let!(:transaction4) { create(:transaction, invoice: invoice2, result: 0) }
  let!(:transaction5) { create(:transaction, invoice: invoice3, result: 1) }
  let!(:transaction6) { create(:transaction, invoice: invoice3, result: 1) }

  let!(:invoice_item1) { create(:invoice_item, item: item1, invoice: invoice1, quantity: 12, unit_price: 100, status: 2) }
  let!(:invoice_item2) { create(:invoice_item, item: item1, invoice: invoice3, quantity: 6, unit_price: 4, status: 1) }
  let!(:invoice_item3) { create(:invoice_item, item: item2, invoice: invoice1, quantity: 3, unit_price: 200, status: 0) }
  let!(:invoice_item4) { create(:invoice_item, item: item2, invoice: invoice2, quantity: 22, unit_price: 200, status: 2) }
  let!(:invoice_item5) { create(:invoice_item, item: item3, invoice: invoice3, quantity: 5, unit_price: 300, status: 1) }
  let!(:invoice_item6) { create(:invoice_item, item: item3, invoice: invoice1, quantity: 63, unit_price: 400, status: 0) }
  let!(:invoice_item7) { create(:invoice_item, item: item4, invoice: invoice2, quantity: 16, unit_price: 500, status: 2) }
  let!(:invoice_item8) { create(:invoice_item, item: item4, invoice: invoice3, quantity: 1, unit_price: 500, status: 1) }
  let!(:invoice_item9) { create(:invoice_item, item: item5, invoice: invoice2, quantity: 2, unit_price: 500, status: 0) }
  let!(:invoice_item10) { create(:invoice_item, item: item5, invoice: invoice1, quantity: 7, unit_price: 200, status: 2) }
  let!(:invoice_item11) { create(:invoice_item, item: item6, invoice: invoice3, quantity: 1, unit_price: 100, status: 1) }
  let!(:invoice_item12) { create(:invoice_item, item: item6, invoice: invoice3, quantity: 1, unit_price: 250, status: 0) }

  describe 'User Story 1 - Admin Merchants Index' do

    it "can display all the merchants" do
      visit '/admin/merchants'

      expect(page).to have_content(merchants[0].name)
      expect(page).to have_content(merchants[1].name)
    end
  end

  describe "Admin Merchant Enable/Disable" do
    it "has a button to disable or enable each merchant and updates status" do
      visit '/admin/merchants'

      within '#enabledMerchants' do
        expect(page).to have_button('Disable')
        expect(page).to have_content(merchant2.name)
        expect(page).to have_content(merchant4.name)

        expect(page).to_not have_content(merchant1.name)
        expect(page).to_not have_content(merchant3.name)
        expect(page).to_not have_button('Enable')
      end
      within '#disabledMerchants' do
        expect(page).to have_button('Enable')
        expect(page).to have_content(merchant1.name)
        expect(page).to have_content(merchant3.name)

        expect(page).to_not have_content(merchant2.name)
        expect(page).to_not have_content(merchant4.name)
        expect(page).to_not have_button('Disable')
      end
      expect(merchant2.status).to eq("enabled")
      within "#enabled-#{merchant2.id}" do
        click_button "Disable"
      end

      expect(current_path).to eq("/admin/merchants")
      merchant2.reload
      expect(merchant2.status).to eq("disabled")
      within '#enabledMerchants' do
        expect(page).to_not have_content(merchant2.name)
      end
      within '#disabledMerchants' do
        expect(page).to have_content(merchant2.name)
      end
      expect(merchant3.status).to eq("disabled")
      within "#disabled-#{merchant3.id}" do
        click_button "Enable"
      end

      expect(current_path).to eq("/admin/merchants")
      merchant3.reload
      expect(merchant3.status).to eq("enabled")
      within '#enabledMerchants' do
        expect(page).to have_content(merchant3.name)
      end
      within '#disabledMerchants' do
        expect(page).to_not have_content(merchant3.name)
      end
    end

    it 'is grouped into sections by status' do
      visit '/admin/merchants'
      expect(page).to have_content("Enabled Merchants")
      expect(page).to have_content("Disabled Merchants")

      within "#disabledMerchants" do
        expect(page).to have_button('Enable')
        expect(page).to have_content(merchant1.name)
        expect(page).to have_content(merchant3.name)
        expect(page).to_not have_content(merchant2.name)
      end

      within "#enabledMerchants" do
        expect(page).to have_button('Disable')
        expect(page).to have_content(merchant2.name)
        expect(page).to have_content(merchant4.name)
        expect(page).to_not have_content(merchant3.name)
      end
    end
  end

  describe 'admin merchant create' do
    it 'has a link to create a new merchant' do
      visit "/admin/merchants"

      expect(page).to have_content("Create New Merchant")
      click_link "Create New Merchant"
      expect(current_path).to eq(new_merchant_path)
    end
  end

  describe 'top five merchants by revenue' do
    it 'lists the names of the top five merchants and their revenue' do 
      visit '/admin/merchants'

      within "#rightSide2" do 
        expect(page).to have_content("Top Merchants")
        expect(page).to have_content
      end
    end
  end
  describe "Admin Merchants: Top Merchant's Best Day" do
    xit "can calculate the date with the most sales" do
    end
  end
end
