require 'rails_helper'

RSpec.describe 'Admin Merchant Index' do
  describe 'view' do

    it 'I see the name of each merchant in the system' do
      visit "/admin/merchants"

      expect(page).to have_content("Merchants")
      expect(page).to have_content(@merchant_1.name)
    end

    it 'Each id links to the admin merchant show page' do
      visit "/admin/merchants"

      within("#all_merchants") do
        click_link "#{@merchant_1.name}"
      end
      expect(current_path).to eq("/admin/merchants/#{@merchant_1.id}")
    end

    it 'includes section for Top Five Merchants based on revenue' do
      visit "/admin/merchants"

      expect(page).to have_content("Top Five Merchants")
    end

    it 'displays links to Top Five Merchants show page and their total revenue' do
      merchant_2 = Merchant.create!(name: "Bill")
      merchant_3 = Merchant.create!(name: "Barbara")
      merchant_4 = Merchant.create!(name: "Lizzy")
      merchant_5 = Merchant.create!(name: "Paul")
      merchant_6 = Merchant.create!(name: "Theo")

      most_expensive_item = merchant_2.items.create!(name: "Most Expensive Item", description: "Description", unit_price: 10000000)
      extremely_expensive_item = merchant_3.items.create!(name: "Extremely Expensive Item", description: "Description", unit_price: 5000000)
      mega_expensive_item = merchant_4.items.create!(name: "Mega Expensive Item", description: "Description", unit_price: 2000000)
      super_expensive_item = merchant_5.items.create!(name: "Super Expensive Item", description: "Description", unit_price: 1000000)

      super_rich_customer = Customer.create!(first_name: "Billionaire", last_name: "Person")

      new_invoice_1 = super_rich_customer.invoices.create!
      new_invoice_2 = super_rich_customer.invoices.create!
      new_invoice_3 = super_rich_customer.invoices.create!
      new_invoice_4 = super_rich_customer.invoices.create!

      new_invoice_1.invoice_items.create!(item_id: most_expensive_item.id, quantity: 1, unit_price: most_expensive_item.unit_price, status: 1)
      new_invoice_2.invoice_items.create!(item_id: extremely_expensive_item.id, quantity: 1, unit_price: extremely_expensive_item.unit_price, status: 1)
      new_invoice_3.invoice_items.create!(item_id: mega_expensive_item.id, quantity: 1, unit_price: mega_expensive_item.unit_price, status: 1)
      new_invoice_4.invoice_items.create!(item_id: super_expensive_item.id, quantity: 1, unit_price: super_expensive_item.unit_price, status: 1)

      new_invoice_1.transactions.create!(credit_card_number: "1111 1111 1111 1111", result: "success")
      new_invoice_2.transactions.create!(credit_card_number: "1111 1111 1111 1111", result: "success")
      new_invoice_3.transactions.create!(credit_card_number: "1111 1111 1111 1111", result: "success")
      new_invoice_4.transactions.create!(credit_card_number: "1111 1111 1111 1111", result: "success")

      visit "/admin/merchants"

      within("#top_five_merchants") do
        expect(merchant_2.name).to appear_before(merchant_3.name)
        expect(merchant_3.name).to appear_before(merchant_4.name)
        expect(merchant_4.name).to appear_before(merchant_5.name)
        expect(merchant_5.name).to appear_before(@merchant_1.name)
      end

      Merchant.top_five_merchants.each do |merchant|
      within("#merchant-#{merchant.name}") do
          expect(page).to have_link("#{merchant.name}")
          expect(page).to have_content(h.number_to_currency(merchant.revenue/100, precision: 0))
        end
      end
    end
  end
end
