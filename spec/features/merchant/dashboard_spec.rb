require 'rails_helper'

RSpec.describe 'Merchant Dashboard Index' do
  describe 'view' do
    before(:each) do
      @merchant_1 = Merchant.create!(name: "Frank")
    end

    it 'displays the name of the Merchant' do
      visit "/merchants/#{@merchant_1.id}/dashboard"

      expect(page).to have_content(@merchant_1.name)
    end

    it 'displays a link to merchant items index page' do
      visit "/merchants/#{@merchant_1.id}/dashboard"

      expect(page).to have_link("Items")
      click_link "Items"
      expect(current_path).to eq("/merchants/#{@merchant_1.id}/items")
    end

    it 'displays a link to merchant invoices index page' do
      visit "/merchants/#{@merchant_1.id}/dashboard"

      expect(page).to have_link("Invoices")
      click_link "Invoices"
      expect(current_path).to eq("/merchants/#{@merchant_1.id}/invoices")
    end

    xit 'shows the names of the top 5 customers and their number of successful transactions' do
      visit "/merchants/#{@merchant_1.id}/dashboard"

      expect(page).to have_content("Top 5 Customers")
      expect(page).to have_content("#{@customer_2.name}: 2 successful transactions")
      expect(page).to have_content("#{@customer_3.name}: 3 successful transactions")
      expect(page).to have_content("#{@customer_4.name}: 4 successful transactions")
      expect(page).to have_content("#{@customer_5.name}: 4 successful transactions")
      expect(page).to have_content("#{@customer_6.name}: 4 successful transactions")
    end

    it 'lists names of items that are ordered but not shipped' do
      visit "/merchants/#{@merchant_1.id}/dashboard"

      expect(page).to have_content("Items Ready to Ship")
      expect(page).to have_content("#{@item_1.name}")
      expect(page).to have_content("#{@item_2.name}")
      expect(page).to have_content("#{@item_3.name}")
      expect(page).to have_content("#{@item_4.name}")
    end

    it 'has an invoice id link next to each item that is ordered but not shipped' do
      visit "/merchants/#{@merchant_1.id}/dashboard"

      expect(page).to have_link("#{@invoice_1.id}")
      expect(page).to have_link("#{@invoice_2.id}")
      expect(page).to have_link("#{@invoice_3.id}")
      expect(page).to have_link("#{@invoice_4.id}")
    end

    xit 'includes date that invoice was created' do
      visit "/merchants/#{@merchant_1.id}/dashboard"

      expect(page).to have_content("#{@invoice_1.created_at}")
      expect(page).to have_content("#{@invoice_2.created_at}")
      expect(page).to have_content("#{@invoice_3.created_at}")
      expect(page).to have_content("#{@invoice_4.created_at}")
    end

    xit 'sorts invoices from oldest to newest' do
      visit "/merchants/#{@merchant_1.id}/dashboard"

      expect(@invoice_1.name).to appear_before(@invoice_2.name)
      expect(@invoice_2.name).to appear_before(@invoice_3.name)
      expect(@invoice_3.name).to appear_before(@invoice_4.name)

      expect(page).to have_content(@invoice_1.created_at.strftime("%m%d%y"))
    end
  end
end
