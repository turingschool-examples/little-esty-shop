require 'rails_helper'

RSpec.describe 'Merchant Dashboard' do

  before :each do
    @merchant = Merchant.create!(name: "Al Capone", created_at: Time.now, updated_at: Time.now)

    @item_1 = Item.create!(name: "Moonshine", description: "alcohol", unit_price: 2, created_at: Time.now, updated_at: Time.now, merchant_id: @merchant.id)
    @item_2 = Item.create!(name: "Hat", description: "hat", unit_price: 2, created_at: Time.now, updated_at: Time.now, merchant_id: @merchant.id)

    @customer_1 = Customer.create!(first_name: "Babe", last_name: "Ruth", created_at: Time.now, updated_at: Time.now)
    @customer_2 = Customer.create!(first_name: "Charles", last_name: "Bukowski", created_at: Time.now, updated_at: Time.now)
    @customer_3 = Customer.create!(first_name: "Josey", last_name: "Wales", created_at: Time.now, updated_at: Time.now)
    @customer_4 = Customer.create!(first_name: "Popcorn", last_name: "Sutton", created_at: Time.now, updated_at: Time.now)
    @customer_5 = Customer.create!(first_name: "Nucky", last_name: "Johnson", created_at: Time.now, updated_at: Time.now)
    @customer_6 = Customer.create!(first_name: "Freddy", last_name: "McCoy", created_at: Time.now, updated_at: Time.now)
    @customer_7 = Customer.create!(first_name: "Ted", last_name: "Williams", created_at: Time.now, updated_at: Time.now)

    @invoice_1 = Invoice.create!(status: 0, created_at: '2022-07-30 00:00:00 UTC', updated_at: Time.now, customer_id: @customer_1.id)
    @invoice_2 = Invoice.create!(status: 0, created_at: '2022-07-29 00:00:00 UTC', updated_at: Time.now, customer_id: @customer_2.id)
    @invoice_3 = Invoice.create!(status: 0, created_at: '2022-07-28 00:00:00 UTC', updated_at: Time.now, customer_id: @customer_3.id)
    @invoice_4 = Invoice.create!(status: 0, created_at: Time.now, updated_at: Time.now, customer_id: @customer_4.id)
    @invoice_5 = Invoice.create!(status: 0, created_at: Time.now, updated_at: Time.now, customer_id: @customer_5.id)
    @invoice_6 = Invoice.create!(status: 0, created_at: Time.now, updated_at: Time.now, customer_id: @customer_6.id)

    @transaction_1 = Transaction.create!(credit_card_number: "1234", credit_card_expiration_date: "042023", result: "success", created_at: Time.now, updated_at: Time.now, invoice_id: @invoice_1.id)
    @transaction_2 = Transaction.create!(credit_card_number: "1234", credit_card_expiration_date: "042023", result: "success", created_at: Time.now, updated_at: Time.now, invoice_id: @invoice_1.id)
    @transaction_3 = Transaction.create!(credit_card_number: "1234", credit_card_expiration_date: "042023", result: "success", created_at: Time.now, updated_at: Time.now, invoice_id: @invoice_1.id)
    @transaction_4 = Transaction.create!(credit_card_number: "1234", credit_card_expiration_date: "042023", result: "success", created_at: Time.now, updated_at: Time.now, invoice_id: @invoice_1.id)
    @transaction_5 = Transaction.create!(credit_card_number: "1234", credit_card_expiration_date: "042023", result: "success", created_at: Time.now, updated_at: Time.now, invoice_id: @invoice_1.id)
    @transaction_6 = Transaction.create!(credit_card_number: "5678", credit_card_expiration_date: "052023", result: "success", created_at: Time.now, updated_at: Time.now, invoice_id: @invoice_2.id)
    @transaction_7 = Transaction.create!(credit_card_number: "5678", credit_card_expiration_date: "052023", result: "success", created_at: Time.now, updated_at: Time.now, invoice_id: @invoice_2.id)
    @transaction_8 = Transaction.create!(credit_card_number: "5678", credit_card_expiration_date: "052023", result: "success", created_at: Time.now, updated_at: Time.now, invoice_id: @invoice_2.id)
    @transaction_9 = Transaction.create!(credit_card_number: "5678", credit_card_expiration_date: "052023", result: "success", created_at: Time.now, updated_at: Time.now, invoice_id: @invoice_2.id)
    @transaction_10 = Transaction.create!(credit_card_number: "9012", credit_card_expiration_date: "062023", result: "success", created_at: Time.now, updated_at: Time.now, invoice_id: @invoice_3.id)
    @transaction_11 = Transaction.create!(credit_card_number: "9012", credit_card_expiration_date: "062023", result: "success", created_at: Time.now, updated_at: Time.now, invoice_id: @invoice_3.id)
    @transaction_12 = Transaction.create!(credit_card_number: "9012", credit_card_expiration_date: "062023", result: "success", created_at: Time.now, updated_at: Time.now, invoice_id: @invoice_3.id)
    @transaction_13 = Transaction.create!(credit_card_number: "3456", credit_card_expiration_date: "072023", result: "success", created_at: Time.now, updated_at: Time.now, invoice_id: @invoice_4.id)
    @transaction_14 = Transaction.create!(credit_card_number: "3456", credit_card_expiration_date: "072023", result: "success", created_at: Time.now, updated_at: Time.now, invoice_id: @invoice_4.id)
    @transaction_15 = Transaction.create!(credit_card_number: "3456", credit_card_expiration_date: "082023", result: "success", created_at: Time.now, updated_at: Time.now, invoice_id: @invoice_5.id)
    @transaction_16 = Transaction.create!(credit_card_number: "3456", credit_card_expiration_date: "092023", result: "success", created_at: Time.now, updated_at: Time.now, invoice_id: @invoice_6.id)

    @invoice_item_1 = InvoiceItem.create!(quantity: 1, unit_price: 2, status: 0, created_at: Time.now, updated_at: Time.now, item_id: @item_1.id, invoice_id: @invoice_1.id)
    @invoice_item_2 = InvoiceItem.create!(quantity: 1, unit_price: 2, status: 1, created_at: Time.now, updated_at: Time.now, item_id: @item_1.id, invoice_id: @invoice_2.id)
    @invoice_item_3 = InvoiceItem.create!(quantity: 1, unit_price: 2, status: 0, created_at: Time.now, updated_at: Time.now, item_id: @item_1.id, invoice_id: @invoice_3.id)
    @invoice_item_4 = InvoiceItem.create!(quantity: 1, unit_price: 2, status: 2, created_at: Time.now, updated_at: Time.now, item_id: @item_1.id, invoice_id: @invoice_4.id)
    @invoice_item_5 = InvoiceItem.create!(quantity: 1, unit_price: 2, status: 0, created_at: Time.now, updated_at: Time.now, item_id: @item_1.id, invoice_id: @invoice_5.id)
    @invoice_item_6 = InvoiceItem.create!(quantity: 1, unit_price: 2, status: 1, created_at: Time.now, updated_at: Time.now, item_id: @item_1.id, invoice_id: @invoice_6.id)

    visit merchant_dashboard_index_path(@merchant)
  end

  describe "I visit a merchant dashboard" do
    it 'displays the merchant name' do
      expect(page).to have_content(@merchant.name)
    end

    it 'as a merchant it displays a link to the my merchant index items page' do
      expect(page).to have_link("My Items Index")

      click_link("My Items Index")

      expect(page).to have_current_path(merchant_items_path(@merchant))
    end

    it "opens my invoice from dashboard index page" do
      expect(page).to have_link("My Invoices Index")

      click_link("My Invoices Index")

      expect(page).to have_current_path(merchant_invoices_path(@merchant))
    end
  end

    it 'displays the the top 5 customers that completed successful transactions for the merchant' do

      expect(page).to have_content(@customer_1.first_name)
      expect(page).to have_content(@customer_1.last_name)
      expect(page).to have_content("Number of Purchases: 5")
    
      expect(page).to have_content(@customer_2.first_name)
      expect(page).to have_content(@customer_2.last_name)
      expect(page).to have_content("Number of Purchases: 4")

      expect(page).to have_content(@customer_3.first_name)
      expect(page).to have_content(@customer_3.last_name)
      expect(page).to have_content("Number of Purchases: 3")

      expect(page).to have_content(@customer_4.first_name)
      expect(page).to have_content(@customer_4.last_name)
      expect(page).to have_content("Number of Purchases: 2")

      expect(page).to have_content(@customer_5.first_name)
      expect(page).to have_content(@customer_5.last_name)
      expect(page).to have_content("Number of Purchases: 1")

      expect(page).to_not have_content(@customer_6.first_name)
      expect(page).to_not have_content(@customer_6.last_name)


      expect(page).to_not have_content(@customer_7.first_name)
      expect(page).to_not have_content(@customer_7.last_name)


      expect(@customer_1.first_name).to appear_before(@customer_2.first_name)
      expect(@customer_2.first_name).to appear_before(@customer_3.first_name)
      expect(@customer_3.first_name).to appear_before(@customer_4.first_name)
      expect(@customer_4.first_name).to appear_before(@customer_5.first_name)
    end

    describe 'Items Ready to Ship' do
      it 'displays items that have been ordered but not yet shipped and has link to the invoice' do
        within(".ready_to_ship") do
          expect(page).to have_content(@item_1.name)
          expect(page).to have_content(@invoice_1.id)

          expect(page).to have_content(@item_1.name)
          expect(page).to have_content(@invoice_2.id)

          expect(page).to have_content(@item_1.name)
          expect(page).to have_content(@invoice_3.id)

          expect(page).to have_content(@item_1.name)
          expect(page).to have_content(@invoice_5.id)

          expect(page).to have_content(@item_1.name)
          expect(page).to have_content(@invoice_6.id)

          expect(page).to_not have_content(@invoice_4.id)

          click_link("#{@invoice_1.id}")

          expect(current_path).to eq(merchant_invoices_path(@merchant, @invoice_1))
        end
      end
    end

  it 'displays the invoice date next to the item and is sorted by least recent' do
    expect(page).to have_content('Saturday, July 30, 2022')
    expect(page).to have_content('Friday, July 29, 2022')
    expect(page).to have_content('Thursday, July 28, 2022')

    expect('Thursday, July 28, 2022').to appear_before('Friday, July 29, 2022')
    expect('Friday, July 29, 2022').to appear_before('Saturday, July 30, 2022')
  end
end
