require 'rails_helper'

RSpec.describe 'application layout' do
  describe 'header content' do
    let!(:jewlery) { Merchant.create!(name: "Jewlery City Merchant")}
    let!(:gold_earrings) { jewlery.items.create!(name: "Gold Earrings", description: "14k Gold 12' Hoops", unit_price: 12000) }
    let!(:alaina) { Customer.create!(first_name: "Alaina", last_name: "Kneiling")}
    let!(:alaina_invoice1) { alaina.invoices.create!(status: "completed", created_at: "2020-01-30 14:54:09")}
    let!(:alainainvoice1_itemgold_earrings) { InvoiceItem.create!(invoice_id: alaina_invoice1.id, item_id: gold_earrings.id, quantity: 4, unit_price: 1300, status:"packaged" )}
    let!(:paths) {[admin_index_path, admin_merchants_path, admin_merchant_path(jewlery),
                   admin_invoices_path, admin_invoice_path(alaina_invoice1),
                   merchant_invoice_path(jewlery, alaina_invoice1), merchant_items_path(jewlery), 
                   merchant_item_path(jewlery, gold_earrings), "/merchants/#{jewlery.id}/dashboard"]}

    it 'displays esty title on every page' do
      paths.each do |path|
        visit path
        within 'header' do
          within '#title' do
            expect(page).to have_content('Esty')
          end
        end
      end
    end

    it 'has nav buttons on every page' do
      paths.each do |path|
        visit path
        within 'header' do
          expect(page).to have_any_of_selectors(:css, '#navbox')
          within '#navbox' do
            expect(page).to have_all_of_selectors(:css, '.navigation', '.divider' )
            expect(page).to have_all_of_selectors(:css, '.navigation', '.div_2' )
          end
        end
      end
    end

    it 'always has a nav tab shaded' do
      paths.each do |path|
        visit path
        within 'header' do
          within '#navbox' do
            expect(page).to have_selector(:css, '.nav-active', count: 1)
          end
        end
      end
    end

    it 'displays shop name when on merchant path' do 
      paths[5..8].each do |path|
        visit path
        within 'header' do
          expect(html).to match(/\w's shop/)
        end
      end
    end

    it 'dispalys admin dashboard when on admin path' do
      paths[0..4].each do |path|
        visit path
        within 'header' do
          expect(html).to have_content('Admin Dashboard')
        end
      end
    end
  end


  describe 'footer content' do
    describe 'api displays' do
      it 'displays github information' do
        visit admin_merchants_path
        within 'footer' do
          expect(html).to match(/Repo name: little-esty-shop | Our total pull requests: \d+/)
          expect(html).to match(/Contributors:\n| \w | \w | \w | \w |/)
        end
      end
    end
  end
end
