require 'rails_helper'

RSpec.describe 'Admin Invoices Index Page', type: :feature do
  let!(:merchant1) { create(:merchant) }

  let!(:item1) { create(:item, merchant: merchant1) }
  let!(:item2) { create(:item, merchant: merchant1) }

  let!(:customer1) { create(:customer) }
  let!(:customer2) { create(:customer) }

  let!(:invoice1) { create(:invoice, customer: customer1) }
  let!(:invoice2) { create(:invoice, customer: customer2) }

  let!(:transaction1) { create(:transaction, invoice: invoice1, result: 1) }
  let!(:transaction2) { create(:transaction, invoice: invoice2, result: 1) }

  let!(:invoice_item1) { create(:invoice_item, item: item1, invoice: invoice1, unit_price: 3011) }
  let!(:invoice_item2) { create(:invoice_item, item: item2, invoice: invoice1, unit_price: 2524) }
  let!(:invoice_item1) { create(:invoice_item, item: item1, invoice: invoice2, unit_price: 3011) }
  let!(:invoice_item2) { create(:invoice_item, item: item2, invoice: invoice2, unit_price: 2524) }

  it 'lists invoice ids' do
    visit "admin/invoices/"
    expect(page).to have_content("Invoice ##{invoice1.id}")
    expect(page).to have_content("Invoice ##{invoice2.id}")
    # click_link invoice1.id.to_s
    # expect(current_path).to eq
  end

  it 'id links to corresponding show page' do
    visit "/admin/invoices/"
    click_link "Invoice ##{invoice1.id}"
    # currently returns error:
    # No route matches [GET] "/admin/invoices/admin/invoices/4547"
    # but if we change the code in the view, our links do not work in "rails s"
    # ??? what gives?
    expect(current_path).to eq("/admin/invoices/#{invoice1.id}")
  end
end
