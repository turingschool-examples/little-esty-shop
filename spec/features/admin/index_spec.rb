 require 'rails_helper'

RSpec.describe "Admin Dashboard", type: :feature do
  let!(:customer) { create(:customer) }

  let!(:invoices) { create_list(:invoice, 4, customer: customer)}

  let!(:invoice_item1) { create(:invoice_item, invoice: invoices[1], status: 2) }
  let!(:invoice_item1) { create(:invoice_item, invoice: invoices[0], status: 2) }
  let!(:invoice_item2) { create(:invoice_item, invoice: invoices[2], status: 1) }
  let!(:invoice_item3) { create(:invoice_item, invoice: invoices[3], status: 0) }
  let!(:invoice_item4) { create(:invoice_item, invoice: invoices[1], status: 1) }
  let!(:invoice_item5) { create(:invoice_item, invoice: invoices[3], status: 0) }

  describe "Admin User Story 1 - Admin Dashboard" do
    it "can display a header" do
      visit '/admin'

      within '#leftSide' do
      expect(page).to have_content("Admin Dashboard")
      end
    end
  end
  describe "Admin User Story 2 - Admin Dashboard Links" do
    it "has a admin merchants index link and admin invoices index link" do
      visit '/admin'
      click_link 'Merchants'
      expect(current_path).to eq('/admin/merchants')

      visit '/admin'
      click_link 'Invoices'
      expect(current_path).to eq('/admin/invoices')
    end
  end

  describe 'incomplete invoices' do
    it 'has a section where you can see the ids of all invoices not yet shipped' do
      visit admin_index_path

      within "#leftSide2" do
        expect(page).to have_content("Incomplete Invoices")
        expect(page).to have_content(invoices[2].id)
        expect(page).to have_content(invoices[1].id)
        expect(page).to have_content(invoices[3].id)
        expect(page).to_not have_content(invoices[0].id)
      end
    end

    it 'has each id as a link to a show page' do
      visit admin_index_path

      within "#leftSide2" do
        expect(page).to have_content("Incomplete Invoices")
        expect(page).to have_link("#{invoices[2].id}")
        expect(page).to have_link("#{invoices[1].id}")
        expect(page).to have_link("#{invoices[3].id}")
        expect(page).to_not have_link("#{invoices[0].id}")
        click_link "#{invoices[2].id}"
      end
      expect(current_path).to eq invoice_path(invoices[2].id)
    end

    it 'has a formatted date for invoices completed and is ordered from oldest to newest' do
      visit admin_index_path
      # save_and_open_page
      within "#leftSide2" do
        expect("#{invoices[3].id}").to appear_before("#{invoices[2].id}")
        expect("#{invoices[2].id}").to appear_before("#{invoices[1].id}")
        expect(page).to have_content("Invoice ##{invoices[1].id} - #{invoices[1].created_at.strftime("%A, %B %d, %Y")}")
        expect(page).to_not have_content("Invoice ##{invoices[0].id}")
      end
    end
  end

  describe "Admin Dashboard Statistics - Top Customers" do
    let!(:merchants) { create_list(:merchant, 2) }
    let!(:customers) { create_list(:customer, 6) }

    let!(:item1) { create(:item, merchant: merchants[0]) }
    let!(:item2) { create(:item, merchant: merchants[1]) }

    let!(:invoice1) { create(:invoice, customer: customers[0]) }
    let!(:invoice2) { create(:invoice, customer: customers[1]) }
    let!(:invoice3) { create(:invoice, customer: customers[2]) }
    let!(:invoice4) { create(:invoice, customer: customers[3]) }
    let!(:invoice5) { create(:invoice, customer: customers[4]) }
    let!(:invoice6) { create(:invoice, customer: customers[5]) }

    let!(:transaction1) { create(:transaction, invoice: invoice1, result: 1) }
    let!(:transaction2) { create(:transaction, invoice: invoice1, result: 1) }
    let!(:transaction3) { create(:transaction, invoice: invoice2, result: 0) }
    let!(:transaction4) { create(:transaction, invoice: invoice2, result: 1) }
    let!(:transaction5) { create(:transaction, invoice: invoice3, result: 0) }
    let!(:transaction6) { create(:transaction, invoice: invoice3, result: 0) }
    let!(:transaction7) { create(:transaction, invoice: invoice4, result: 0) }
    let!(:transaction8) { create(:transaction, invoice: invoice4, result: 1) }
    let!(:transaction9) { create(:transaction, invoice: invoice5, result: 0) }
    let!(:transaction10) { create(:transaction, invoice: invoice5, result: 1) }
    let!(:transaction11) { create(:transaction, invoice: invoice6, result: 0) }
    let!(:transaction12) { create(:transaction, invoice: invoice6, result: 1) }

    let!(:invoice_item1) { create(:invoice_item, item: item1, invoice: invoice1, status: 0) }
    let!(:invoice_item2) { create(:invoice_item, item: item2, invoice: invoice2, status: 1) }
    let!(:invoice_item3) { create(:invoice_item, item: item1, invoice: invoice3, status: 1) }
    let!(:invoice_item4) { create(:invoice_item, item: item2, invoice: invoice4, status: 0) }
    let!(:invoice_item5) { create(:invoice_item, item: item1, invoice: invoice5, status: 0) }
    let!(:invoice_item6) { create(:invoice_item, item: item2, invoice: invoice6, status: 1) }

    it "displays the top 5 customers that have made the most purchases with successful transactions" do
      top_customer = customers[2]
      tied_customers = [customers[1], customers[3], customers[4], customers[5]]
      expected = tied_customers.sort_by(&:last_name).sort_by(&:first_name).unshift(top_customer)

      visit admin_index_path

      within "#rightSide2" do
        expect(page).to have_content("#{expected[0].first_name} #{expected[0].last_name} - 2 purchases")
        expect(page).to have_content("#{expected[1].first_name} #{expected[1].last_name} - 1 purchases")
        expect(page).to have_content("#{expected[2].first_name} #{expected[2].last_name} - 1 purchases")
        expect(page).to have_content("#{expected[3].first_name} #{expected[3].last_name} - 1 purchases")
        expect(page).to have_content("#{expected[4].first_name} #{expected[4].last_name} - 1 purchases")

        expect("#{expected[0].first_name} #{expected[0].last_name}").to appear_before("#{expected[1].first_name} #{expected[1].last_name}")
        expect("#{expected[1].first_name} #{expected[1].last_name}").to appear_before("#{expected[2].first_name} #{expected[2].last_name}")
        expect("#{expected[2].first_name} #{expected[2].last_name}").to appear_before("#{expected[3].first_name} #{expected[3].last_name}")
        expect("#{expected[3].first_name} #{expected[3].last_name}").to appear_before("#{expected[4].first_name} #{expected[4].last_name}")
      end
    end
  end

  describe "wireframe link (no user story)" do
    it "has a link that takes you back to the dashboard" do
      visit admin_index_path
      click_link "Dashboard"
      expect(current_path).to eq(admin_index_path)
    end
  end
end
