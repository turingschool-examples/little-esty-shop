require 'rails_helper'

RSpec.describe 'admin invoices index page' do
  before(:each) do
    @invoice_item = FactoryBot.create(:invoice_item)
    @invoice_item2 = FactoryBot.create(:invoice_item)
    @invoice_item3 = FactoryBot.create(:invoice_item)

    visit "/admin/invoices"
  end

  it 'shows invoice id and links to invoice show page' do
    within("#admin-invoice-#{@invoice_item.invoice_id}") do
      expect(page).to have_content(@invoice_item.invoice_id)
      click_link("#{@invoice_item.invoice_id}")
      expect(current_path).to eq("/admin/invoices/#{@invoice_item.invoice_id}")
    end
  end
  it 'shows invoice2 id and links to show page' do
    within("#admin-invoice-#{@invoice_item2.invoice_id}") do
      expect(page).to have_content(@invoice_item2.invoice_id)
      click_link("#{@invoice_item2.invoice_id}")
      expect(current_path).to eq("/admin/invoices/#{@invoice_item2.invoice_id}")
    end
  end
  it 'shows invoice3 id and links to show page' do
    within("#admin-invoice-#{@invoice_item3.invoice_id}") do
      expect(page).to have_content(@invoice_item3.invoice_id)
      click_link("#{@invoice_item3.invoice_id}")
      expect(current_path).to eq("/admin/invoices/#{@invoice_item3.invoice_id}")
    end
  end
end
