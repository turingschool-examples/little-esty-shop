require 'rails_helper'

RSpec.describe 'Merchant Dashboard' do

  let!(:merchant_1) {Merchant.create!(name: 'Ron Swanson')}

  let!(:item_1) {merchant_1.items.create!(name: "Necklace", description: "A thing around your neck", unit_price: 1000, status: 0)}
  let!(:item_2) {merchant_1.items.create!(name: "Bracelet", description: "A thing around your wrist", unit_price: 900, status: 0)}
  let!(:item_3) {merchant_1.items.create!(name: "Earrings", description: "These go through your ears", unit_price: 1500, status: 1)}
  let!(:item_4) {merchant_1.items.create!(name: "Ring", description: "A thing around your finger", unit_price: 1000)}
  let!(:item_5) {merchant_1.items.create!(name: "Toe Ring", description: "A thing around your neck", unit_price: 800)}
  let!(:item_6) {merchant_1.items.create!(name: "Pendant", description: "A thing to put somewhere", unit_price: 1500)}
  let!(:item_7) {merchant_1.items.create!(name: "Bandana", description: "Many uses", unit_price: 400)}
  let!(:item_8) {merchant_1.items.create!(name: "Hair clip", description: "A thing to clip in your hair", unit_price: 500)}

  let!(:customer_1) {Customer.create!(first_name: "Billy", last_name: "Joel")}
  let!(:customer_2) {Customer.create!(first_name: "Britney", last_name: "Spears")}
  let!(:customer_3) {Customer.create!(first_name: "Prince", last_name: "Mononym")}

  let!(:invoice_1) {customer_1.invoices.create!(status: 1, created_at: '2012-03-25 09:54:09')}
  let!(:invoice_2) {customer_2.invoices.create!(status: 1, created_at: '2012-04-25 08:54:09')}
  let!(:invoice_3) {customer_3.invoices.create!(status: 1, created_at: '2012-10-25 04:54:09')}

  let!(:invoice_item_1) {InvoiceItem.create!(item_id: item_1.id, invoice_id: invoice_1.id, unit_price: 1000, quantity: 1,  status: 0)}
  let!(:invoice_item_2) {InvoiceItem.create!(item_id: item_2.id, invoice_id: invoice_2.id, unit_price: 900, quantity: 1, status: 0)}
  let!(:invoice_item_3) {InvoiceItem.create!(item_id: item_3.id, invoice_id: invoice_3.id, unit_price: 1500, quantity: 2,  status: 0)}
  let!(:invoice_item_4) {InvoiceItem.create!(item_id: item_1.id, invoice_id: invoice_2.id, unit_price: 1000, quantity: 3,  status: 1)}
  let!(:invoice_item_5) {InvoiceItem.create!(item_id: item_1.id, invoice_id: invoice_3.id, unit_price: 1000, quantity: 1,  status: 1)}
  let!(:invoice_item_6) {InvoiceItem.create!(item_id: item_2.id, invoice_id: invoice_1.id, unit_price: 900, quantity: 1, status: 2)}
  let!(:invoice_item_7) {InvoiceItem.create!(item_id: item_7.id, invoice_id: invoice_3.id, unit_price: 400, quantity: 36, status: 2)}
  let!(:invoice_item_8) {InvoiceItem.create!(item_id: item_8.id, invoice_id: invoice_3.id, unit_price: 500, quantity: 2, status: 2)}

  let!(:transaction_1) {invoice_1.transactions.create!(result: 'success')}
  let!(:transaction_2) {invoice_2.transactions.create!(result: 'success')}
  let!(:transaction_3) {invoice_3.transactions.create!(result: 'success')}
  let!(:transaction_4) {invoice_1.transactions.create!(result: 'success')}
  let!(:transaction_5) {invoice_2.transactions.create!(result: 'success')}
  let!(:transaction_6) {invoice_3.transactions.create!(result: 'success')}

  before(:each) do
    visit merchant_items_path(merchant_1.id)
  end

  scenario 'visitor sees the name of all items of particular merchant as links' do
    expect(current_path).to eq(merchant_items_path(merchant_1.id))

    within "#enabled" do
        expect(page).to have_link("#{item_1.name}", href: merchant_item_path(merchant_1.id, item_1.id))
        expect(page).to have_link("#{item_2.name}", href: merchant_item_path(merchant_1.id, item_2.id))
    end

    within "#disabled" do
      expect(page).to have_link("#{item_3.name}", href: merchant_item_path(merchant_1.id, item_3.id))
    end
  end

  scenario 'visitor sees the names of the top 5 most popular items ranked by total revenue generated' do
    expect(page).to have_content('Top 5 Items')
    first = find("#item#{item_7.id}")
    second = find("#item#{item_1.id}")
    third = find("#item#{item_3.id}")
    fourth = find("#item#{item_8.id}")
    fifth = find("#item#{item_2.id}")
    expect(first).to appear_before(second)
    expect(second).to appear_before(third)
    expect(third).to appear_before(fourth)
    expect(fourth).to appear_before(fifth)
  end

  scenario 'visitor sees that each item name in the top item list also links to that item show page' do
    within "#top_five_items-#{merchant_1.id}" do
      expect(page).to have_link(item_7.name)
      expect(page).to have_link(item_1.name)
      expect(page).to have_link(item_3.name)
      expect(page).to have_link(item_8.name)
      expect(page).to have_link(item_2.name)
    end
  end

  scenario 'visitor sees the total revenue generated next to each item name' do
    within "#top_five_items-#{merchant_1.id}" do
      expect(page).to have_content(merchant_1.top_five_items[0].total_revenue.to_f/100)
      expect(page).to have_content(merchant_1.top_five_items[1].total_revenue.to_f/100)
      expect(page).to have_content(merchant_1.top_five_items[2].total_revenue.to_f/100)
      expect(page).to have_content(merchant_1.top_five_items[3].total_revenue.to_f/100)
      expect(page).to have_content(merchant_1.top_five_items[4].total_revenue.to_f/100)
    end
  end

  scenario 'vistor sees date with most sales next to top five most popular items' do
    within "#top_five_items-#{merchant_1.id}" do
      expect(page).to have_content(merchant_1.top_five_items[0].date_with_most_sales)
      expect(page).to have_content(merchant_1.top_five_items[1].date_with_most_sales)
      expect(page).to have_content(merchant_1.top_five_items[2].date_with_most_sales)
      expect(page).to have_content(merchant_1.top_five_items[3].date_with_most_sales)
      expect(page).to have_content(merchant_1.top_five_items[4].date_with_most_sales)
    end
  end

  describe 'item disable/enable button' do
    scenario 'visitor sees a button to disable that item' do
      within "#enabled_item-#{item_1.name}" do
        expect(page).to have_button("Disable")
        click_button "Disable"
      end

      expect(page).to have_button("Enable")
      expect(current_path).to eq(merchant_items_path(merchant_1.id))
    end

    scenario 'visitor sees a button to disable that item' do
      within "#disabled_item-#{item_3.name}" do
        expect(page).to have_button("Enable")
        click_button "Enable"
      end

      expect(page).to have_button("Disable")
      expect(current_path).to eq(merchant_items_path(merchant_1.id))
    end
  end

  describe 'creating an item' do
    scenario 'visitor sees a link to create a new item' do
      expect(page).to have_link("Create Item", href: new_merchant_item_path(merchant_1.id))
    end

    scenario 'visitor clicks link and is taken to form to add info' do
      click_link "Create Item"

      fill_in(:name, with: 'Rare Pokemon Card')
      fill_in(:description, with: 'Holograph Machamp')
      fill_in(:unit_price, with: 100)

      click_button "Submit"

      expect(current_path).to eq(merchant_items_path(merchant_1.id))
      expect(page).to have_content('Rare Pokemon Card')
    end
  end
end
