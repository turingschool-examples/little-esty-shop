require 'rails_helper'

RSpec.describe 'Admin Invoice Show Page', type: :feature do
  it 'lists invoice attributes' do
    merchant1 = create(:merchant)
    item1 = create(:item, merchant: merchant1)
    item2 = create(:item, merchant: merchant1)
    customer1 = create(:customer)
    invoice1 = create(:invoice, customer: customer1, status: 0)
    transaction1 = create(:transaction, invoice: invoice1, result: 1)
    invoice_item1 = create(:invoice_item, item: item1, invoice: invoice1, unit_price: 3011)
    invoice_item2 = create(:invoice_item, item: item2, invoice: invoice1, unit_price: 2524)
    visit "/admin/invoices/#{invoice1.id}"
    # expect(page).to have_content("Status: #{invoice1.status}")
    expect(page).to have_content("Invoice ##{invoice1.id}")
    expect(page).to have_content("Created on: #{invoice1.created_at.strftime('%A, %B %d, %Y')}")
    expect(page).to have_content("#{invoice1.customer.first_name} #{invoice1.customer.last_name}")
  end

  it 'lists items on the invoice' do
    merchant1 = create(:merchant)
    item1 = create(:item, merchant: merchant1)
    item2 = create(:item, merchant: merchant1)
    customer1 = create(:customer)
    invoice1 = create(:invoice, customer: customer1, status: 0)
    transaction1 = create(:transaction, invoice: invoice1, result: 1)
    invoice_item1 = create(:invoice_item, item: item1, invoice: invoice1, unit_price: 3011)
    invoice_item2 = create(:invoice_item, item: item2, invoice: invoice1, unit_price: 2524)
    visit "/admin/invoices/#{invoice1.id}"
    within '#itemtable' do
      expect(page).to have_content('Item Name')
      expect(page).to have_content('Unit Price')
      expect(page).to have_content('Status')
      expect(page).to have_content('Quantity')
    end

    within "#invoice-item-#{invoice_item1.id}" do
      expect(page).to have_text(item1.name.to_s)
      expect(page).to have_text('$30.11')
      expect(page).to have_text(invoice_item1.quantity.to_s)
      expect(page).to have_text(invoice_item1.status.to_s)
    end
  end

  it 'shows total revenue that will be generated from this invoice' do
    merchant1 = create(:merchant)
    item1 = create(:item, merchant: merchant1)
    item2 = create(:item, merchant: merchant1)
    customer1 = create(:customer)
    invoice1 = create(:invoice, customer: customer1, status: 0)
    transaction1 = create(:transaction, invoice: invoice1, result: 1)
    invoice_item1 = create(:invoice_item, item: item1, invoice: invoice1, unit_price: 3011, quantity: 2)
    invoice_item2 = create(:invoice_item, item: item2, invoice: invoice1, unit_price: 2524, quantity: 1)
    visit "/admin/invoices/#{invoice1.id}"

    expect(page).to have_content('Total Revenue: $8,546.00')
  end

  it 'has a select field to update invoice status' do
    merchant1 = create(:merchant)
    item1 = create(:item, merchant: merchant1)
    item2 = create(:item, merchant: merchant1)
    customer1 = create(:customer)
    invoice1 = create(:invoice, customer: customer1, status: 0)
    transaction1 = create(:transaction, invoice: invoice1, result: 1)
    invoice_item1 = create(:invoice_item, item: item1, invoice: invoice1, unit_price: 3011)
    invoice_item2 = create(:invoice_item, item: item2, invoice: invoice1, unit_price: 2524)
    visit "/admin/invoices/#{invoice1.id}"

    expect(invoice1.status).to eq('in progress')

    have_select :status,
                selected: 'in progress',
                options: ['in progress', 'completed', 'cancelled']

    select 'completed', from: :status
    click_button 'Update Invoice Status'

    expect(current_path).to eq("/admin/invoices/#{invoice1.id}")
    invoice1.reload
    expect(invoice1.status).to eq('completed')

    have_select :status,
                selected: 'completed',
                options: ['in progress', 'completed', 'cancelled']
  end

  describe 'Admin Invoice Show Page: Total Revenue and Discounted Revenue' do
    it "shows total discounted revenue for all merchants" do
      merchant1 = create(:merchant, name: "Jimmy")
      merchant2 = create(:merchant, name: "Phillip")
      customer1 = create(:customer, first_name: 'Luke', last_name: 'Skywalker')
      invoice1 = create(:invoice, customer: customer1)
      invoice2 = create(:invoice, customer: customer1)
      item1 = create(:item, merchant: merchant1, name: "Toy")
      item2 = create(:item, merchant: merchant1, name: "Lightsaber")
      item3 = create(:item, merchant: merchant2, name: "Jetpack")
      invoice_item1 = create(:invoice_item, item: item1, invoice: invoice1, quantity: 15, unit_price: 100)
      invoice_item2 = create(:invoice_item, item: item2, invoice: invoice1, quantity: 10, unit_price: 500)
      invoice_item3 = create(:invoice_item, item: item3, invoice: invoice1, quantity: 20, unit_price: 700)
      invoice_item3 = create(:invoice_item, item: item3, invoice: invoice2, quantity: 1, unit_price: 1)
      bulk_discount1 = merchant1.bulk_discounts.create!(threshold: 15, discount_percentage: 20)
      bulk_discount2 = merchant1.bulk_discounts.create!(threshold: 15, discount_percentage: 30)
      bulk_discount3 = merchant1.bulk_discounts.create!(threshold: 15, discount_percentage: 40)
      bulk_discount4 = merchant1.bulk_discounts.create!(threshold: 20, discount_percentage: 30)
      bulk_discount5 = merchant1.bulk_discounts.create!(threshold: 15, discount_percentage: 30)
      bulk_discount6 = merchant2.bulk_discounts.create!(threshold: 15, discount_percentage: 30)

      visit "/admin/invoices/#{invoice1.id}"

      expect(page).to have_content("Discounted Revenue: $15,700.00")
      expect(page).to_not have_content("$1.00")
      expect(page).to have_content("Total Revenue: $20,500.00")


    end
  end
end
