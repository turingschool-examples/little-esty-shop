require 'rails_helper'

describe 'Admin Merchants index page' do
  describe 'As an admin' do
    describe 'When I visit the admin merchants index (/admin/merchants)' do
      let!(:customer_1) { create(:customer)  }
      let!(:merchant_1) {create(:merchant) }
      let!(:invoice_1) {create(:invoice, customer_id: customer_1.id) }
      let!(:item_1) {create(:item, merchant_id: merchant_1.id) }
      let!(:invoice_item_1) {create(:invoice_item, item_id: item_1.id, quantity: 10, unit_price: 10, invoice_id: invoice_1.id ) }
      let!(:invoice_item_2)  {create(:invoice_item, item_id: item_1.id, quantity: 10, unit_price: 10, invoice_id: invoice_1.id ) }
      let!(:transaction_1) {create(:transaction, invoice_id: invoice_1.id, result: 'success') }
      let!(:transaction_6) {create(:transaction, invoice_id: invoice_1.id, result: 'failure') }

      let!(:customer_2) {create(:customer) }
      let!(:merchant_2) {create(:merchant) }
      let!(:invoice_2) {create(:invoice, customer_id: customer_2.id) }
      let!(:item_2) {create(:item, merchant_id: merchant_2.id) }
      let!(:invoice_item_3) {create(:invoice_item, item_id: item_2.id, quantity: 10, unit_price: 9, invoice_id: invoice_2.id ) }
      let!(:invoice_item_4) {create(:invoice_item, item_id: item_2.id, quantity: 10, unit_price: 9, invoice_id: invoice_2.id ) }
      let!(:transaction_2) {create(:transaction, invoice_id: invoice_2.id, result: 'success') }

      let!(:customer_3) {create(:customer) }
      let!(:merchant_3) {create(:merchant) }
      let!(:invoice_3) {create(:invoice, customer_id: customer_3.id) }
      let!(:item_3) {create(:item, merchant_id: merchant_3.id) }
      let!(:invoice_item_4) {create(:invoice_item, item_id: item_3.id, quantity: 10, unit_price: 8, invoice_id: invoice_3.id ) }
      let!(:invoice_item_5) {create(:invoice_item, item_id: item_3.id, quantity: 10, unit_price: 8, invoice_id: invoice_3.id ) }
      let!(:transaction_3) {create(:transaction, invoice_id: invoice_3.id, result: 'success') }

      let!(:customer_4) {create(:customer) }
      let!(:merchant_4) {create(:merchant) }
      let!(:invoice_4) {create(:invoice, customer_id: customer_4.id) }
      let!(:item_4) {create(:item, merchant_id: merchant_4.id) }
      let!(:invoice_item_5) {create(:invoice_item, item_id: item_4.id, quantity: 10, unit_price: 7, invoice_id: invoice_4.id ) }
      let!(:invoice_item_6) {create(:invoice_item, item_id: item_4.id, quantity: 10, unit_price: 7, invoice_id: invoice_4.id ) }
      let!(:transaction_4) {create(:transaction, invoice_id: invoice_4.id, result: 'success') }

      let!(:customer_5) {create(:customer) }
      let!(:merchant_5) {create(:merchant) }
      let!(:invoice_5) {create(:invoice, customer_id: customer_5.id) }
      let!(:item_5 ) {create(:item, merchant_id: merchant_5.id) }
      let!(:invoice_item_6) {create(:invoice_item, item_id: item_5.id, quantity: 10, unit_price: 6, invoice_id: invoice_5.id ) }
      let!(:invoice_item_7) {create(:invoice_item, item_id: item_5.id, quantity: 10, unit_price: 6, invoice_id: invoice_5.id ) }
      let!(:transaction_5) {create(:transaction, invoice_id: invoice_5.id, result: 'success') }

      let!(:customer_6) {create(:customer) }
      let!(:merchant_6) {create(:merchant) }
      let!(:invoice_6 ) {create(:invoice, customer_id: customer_6.id) }
      let!(:item_6) {create(:item, merchant_id: merchant_6.id) }
      let!(:invoice_item_7) {create(:invoice_item, item_id: item_6.id, quantity: 10, unit_price: 20, invoice_id: invoice_6.id ) }
      let!(:invoice_item_8) {create(:invoice_item, item_id: item_6.id, quantity: 10, unit_price: 20, invoice_id: invoice_6.id ) }
      let!(:transaction_6) {create(:transaction, invoice_id: invoice_6.id, result: 'failure') }
  
      it "Then I see the name of each merchant in the system" do
        visit admin_merchants_path

        expect(page).to have_content("#{merchant_1.name}")
        expect(page).to have_content("#{merchant_2.name}")
        expect(page).to have_content("#{merchant_3.name}")
        expect(page).to have_content("#{merchant_4.name}")
        expect(page).to have_content("#{merchant_5.name}")
        expect(page).to have_content("#{merchant_6.name}")
      end

      it "I see a link to create a new merchant. When I click I am taken to a form that allows me to add merchant information.When I fill out the form I click ‘Submit’ Then I am taken back to the admin merchants index page And I see the merchant I just created displayed And I see my merchant was created with a default status of disabled. " do

        visit admin_merchants_path
        click_link('Create a new merchant')

        expect(current_path).to eq(new_admin_merchant_path)
        expect(page).to have_content("Create a New Merchant")
        expect(page).to have_field("Name")

        fill_in("Name", with: 'All the Shoes')
        click_button("Submit")
       
        expect(current_path).to eq(admin_merchants_path)
        expect(page).to have_content('All the Shoes')
      end

      it "I see the names of the top 5 merchants by total revenue generated and I see that each merchant name links to the admin merchant show page for that merchant and I see the total reveneue generated next to each merchant name" do
        visit admin_merchants_path

        expect(page).to have_content('Top 5 merchants by total revenue generated:')
        within('.top') do
          expect(merchant_1.name).to appear_before(merchant_2.name)
          expect(merchant_2.name).to appear_before(merchant_3.name)
          expect(merchant_4.name).to appear_before(merchant_5.name)
        end
      end
    end
  end
end