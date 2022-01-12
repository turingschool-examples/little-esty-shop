require 'rails_helper'

RSpec.describe 'Merchant items show page' do

    let!(:merchant_1) {Merchant.create!(name: 'Ron Swanson')}

    let!(:item_1) {merchant_1.items.create!(name: "Necklace", description: "A thing around your neck", unit_price: 100)}
    let!(:item_2) {merchant_1.items.create!(name: "Bracelet", description: "A thing around your neck", unit_price: 100)}
    let!(:item_3) {merchant_1.items.create!(name: "Earrings", description: "A thing around your neck", unit_price: 100)}

    let!(:customer_1) {Customer.create!(first_name: "Billy", last_name: "Joel")}
    let!(:customer_2) {Customer.create!(first_name: "Britney", last_name: "Spears")}
    let!(:customer_3) {Customer.create!(first_name: "Prince", last_name: "Mononym")}

    let!(:invoice_1) {customer_1.invoices.create!(status: 1, created_at: '2012-03-25 09:54:09')}
    let!(:invoice_2) {customer_2.invoices.create!(status: 1, created_at: '2012-04-25 08:54:09')}
    let!(:invoice_3) {customer_3.invoices.create!(status: 1, created_at: '2012-10-25 04:54:09')}

    let!(:invoice_item_1) {InvoiceItem.create!(item_id: item_1.id, invoice_id: invoice_1.id, unit_price: item_1.unit_price, quantity: 2, status: 0)}
    let!(:invoice_item_2) {InvoiceItem.create!(item_id: item_2.id, invoice_id: invoice_2.id, unit_price: item_2.unit_price, quantity: 2, status: 0)}
    let!(:invoice_item_3) {InvoiceItem.create!(item_id: item_3.id, invoice_id: invoice_3.id, unit_price: item_3.unit_price, quantity: 2, status: 0)}

    let!(:transaction_1) {invoice_1.transactions.create!(result: 'success')}
    let!(:transaction_2) {invoice_2.transactions.create!(result: 'success')}
    let!(:transaction_3) {invoice_3.transactions.create!(result: 'success')}

    before(:each) do
        visit merchant_item_path(merchant_1.id, item_3.id)
    end

    scenario 'merchant sees item show page when clicking on item link on index page' do
        visit merchant_items_path(merchant_1.id)

        within "#top_five_items-#{merchant_1.id}" do
            click_link("#{item_3.name}")
        end

        expect(current_path).to eq(merchant_item_path(merchant_1.id, item_3.id))
    end

    scenario 'merchant sees list of item attributes on item show page' do
        expect(page).to have_content(item_3.name)
        expect(page).to have_content(item_3.description)
        expect(page).to have_content(item_3.unit_price.to_f/100)
    end

    describe 'merchant item update' do
        scenario 'merchant sees link to update item info' do
            visit merchant_item_path(merchant_1.id, item_1.id)
            expect(page).to have_link("Update Item", href: edit_merchant_item_path(merchant_1.id, item_1.id))
        end

        scenario 'merchant clicks link to edit item' do
            visit merchant_item_path(merchant_1.id, item_1.id)
            click_link "Update Item"
            expect(current_path).to eq(edit_merchant_item_path(merchant_1.id, item_1.id))
        end

        scenario 'merchant fills out form' do
            visit edit_merchant_item_path(merchant_1.id, item_1.id)
            fill_in("Name", with: "Charlie Murphy's Ring")
            fill_in("Description", with: "Rick James")
            fill_in("Unit Price", with: 10000)
            click_button("Update")
            expect(current_path).to eq(merchant_item_path(merchant_1.id, item_1.id))
            expect(page).to have_content("Charlie Murphy's Ring")
            expect(page).to have_content("Item has been updated!")
        end
    end
end
