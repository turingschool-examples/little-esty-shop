require 'rails_helper'
require 'spec_helper'

RSpec.describe ApplicationHelper, type: :helper do

  describe 'instance methods' do
    describe '#path_request' do
      it 'returns current path' do
        expect(helper.path_request).to be_a(String)
      end
    end

    describe '#current_class?' do
      let!(:jewlery) { Merchant.create!(name: "Jewlery City Merchant")}
      let!(:gold_earrings) { jewlery.items.create!(name: "Gold Earrings", description: "14k Gold 12' Hoops", unit_price: 12000) }
      let!(:alaina) { Customer.create!(first_name: "Alaina", last_name: "Kneiling")}
      let!(:alaina_invoice1) { alaina.invoices.create!(status: "completed", created_at: "2020-01-30 14:54:09")}
      let!(:alainainvoice1_itemgold_earrings) { InvoiceItem.create!(invoice_id: alaina_invoice1.id, item_id: gold_earrings.id, quantity: 4, unit_price: 1300, status:"packaged" )}
      let!(:paths) { ['/admin', "/admin/merchants", "/admin/merchants/#{jewlery.id}",
                      "/admin/invoices", "/admin/invoices/#{alaina_invoice1.id}",
                      "/merchants/#{jewlery.id}/invoices", "/merchants/#{jewlery.id}/invoices/#{alaina_invoice1.id}",
                      "/merchants/#{jewlery.id}/items", "/merchants/#{jewlery.id}/items/#{gold_earrings.id}", 
                      "/merchants/#{jewlery.id}/dashboard"] }

      describe 'admin namespace' do
        it 'returns nav-active for "/admin" only if on admin home' do
          paths.each do |path|
            allow(helper).to receive(:path_request).and_return(path)
            if path == admin_index_path
              expect(helper.current_class?('/admin')).to eq('nav-active')
            else
              expect(helper.current_class?('/admin')).to eq('')
            end
          end
        end

        it 'returns nav-active for "/admin/merchants" only if on any admin/merchants page and not admin home' do
          paths.each do |path|
            allow(helper).to receive(:path_request).and_return(path)
            if path == admin_merchants_path || path == admin_merchant_path(jewlery)
              expect(helper.current_class?('/admin/merchants')).to eq('nav-active')
            else
              expect(helper.current_class?('/admin/merchants')).to eq('')
            end
          end
        end

        it 'returns nav-active for "/admin/invoices" only if on any admin/invoice page and not admin home' do
          paths.each do |path|
            allow(helper).to receive(:path_request).and_return(path)
            if path == admin_invoices_path || path == admin_invoice_path(alaina_invoice1)
              expect(helper.current_class?('/admin/invoices')).to eq('nav-active')
            else
              expect(helper.current_class?('/admin/invoices')).to eq('')
            end
          end
        end
      end

      describe 'merchant namespace' do
        it 'returns nav-active for "/merchants/:id/dashboard" only if on dashboard' do
          paths.each do |path|
            allow(helper).to receive(:path_request).and_return(path)
            if path == "/merchants/#{jewlery.id}/dashboard"
              expect(helper.current_class?("/merchants/#{jewlery.id}/dashboard")).to eq('nav-active')
            else
              expect(helper.current_class?("/merchants/#{jewlery.id}/dashboard")).to eq('')
            end
          end
        end

        it 'returns nav-active for "/merchants/:id/invoices" only if on any merchants/invoices page' do
          paths.each do |path|
            allow(helper).to receive(:path_request).and_return(path)
            if path == merchant_invoices_path(jewlery) || path == "/merchants/#{jewlery.id}/invoices/#{alaina_invoice1.id}"
              expect(helper.current_class?("/merchants/#{jewlery.id}/invoices")).to eq('nav-active')
            else
              
              expect(helper.current_class?("/merchants/#{jewlery.id}/invoices")).to eq('')
            end
          end
        end

        it 'returns nav-active for "/merchants/:id/items" only if on any admin/items pages and not admin home' do
          paths.each do |path|
            allow(helper).to receive(:path_request).and_return(path)
            if path == merchant_items_path(jewlery) || path == merchant_item_path(jewlery, gold_earrings)
              expect(helper.current_class?("/merchants/#{jewlery.id}/items")).to eq('nav-active')
            else
              expect(helper.current_class?("/merchants/#{jewlery.id}/items")).to eq('')
            end
          end
        end
      end
    end
  end
end