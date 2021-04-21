require 'rails_helper'

RSpec.describe 'As a visitor' do
  before(:each) do
    @merchant_1 = create(:merchant)

    @item_1 = create(:item, merchant: @merchant_1)

    @customer_1 = create(:customer)
    @customer_2 = create(:customer)
    @customer_3 = create(:customer)
    @customer_4 = create(:customer)
    @customer_5 = create(:customer)
    @customer_6 = create(:customer)

    @invoice_1 = create(:invoice, customer_id: @customer_1.id)
    @invoice_2 = create(:invoice, customer_id: @customer_2.id)
    @invoice_3 = create(:invoice, customer_id: @customer_3.id)
    @invoice_4 = create(:invoice, customer_id: @customer_4.id)
    @invoice_5 = create(:invoice, customer_id: @customer_5.id)
    @invoice_6 = create(:invoice, customer_id: @customer_6.id)

    @invoice_item_1 = create(:invoice_item, item_id: @item_1.id, invoice_id: @invoice_1.id)
    @invoice_item_2 = create(:invoice_item, item_id: @item_1.id, invoice_id: @invoice_2.id)
    @invoice_item_3 = create(:invoice_item, item_id: @item_1.id, invoice_id: @invoice_3.id)
    @invoice_item_4 = create(:invoice_item, item_id: @item_1.id, invoice_id: @invoice_6.id)

    @transaction_1 = create(:transaction, invoice_id: @invoice_1.id, result: 0)
    @transaction_2 = create(:transaction, invoice_id: @invoice_1.id, result: 0)
    @transaction_3 = create(:transaction, invoice_id: @invoice_1.id, result: 1)
    @transaction_4 = create(:transaction, invoice_id: @invoice_1.id, result: 1)
    @transaction_5 = create(:transaction, invoice_id: @invoice_1.id, result: 1)
    @transaction_6 = create(:transaction, invoice_id: @invoice_1.id, result: 1)
    @transaction_7 = create(:transaction, invoice_id: @invoice_1.id, result: 1)
    @transaction_8 = create(:transaction, invoice_id: @invoice_1.id, result: 1)
    @transaction_9 = create(:transaction, invoice_id: @invoice_1.id, result: 1)
    @transaction_10 = create(:transaction, invoice_id: @invoice_1.id, result: 1)

    @transaction_11 = create(:transaction, invoice_id: @invoice_2.id, result: 1)
    @transaction_12 = create(:transaction, invoice_id: @invoice_2.id, result: 1)
    @transaction_13 = create(:transaction, invoice_id: @invoice_2.id, result: 1)
    @transaction_14 = create(:transaction, invoice_id: @invoice_2.id, result: 1)
    @transaction_15 = create(:transaction, invoice_id: @invoice_2.id, result: 1)
    @transaction_16 = create(:transaction, invoice_id: @invoice_2.id, result: 1)
    @transaction_17 = create(:transaction, invoice_id: @invoice_2.id, result: 1)
    @transaction_18 = create(:transaction, invoice_id: @invoice_2.id, result: 1)
    @transaction_19 = create(:transaction, invoice_id: @invoice_2.id, result: 1)

    @transaction_20 = create(:transaction, invoice_id: @invoice_3.id, result: 1)
    @transaction_21 = create(:transaction, invoice_id: @invoice_3.id, result: 1)
    @transaction_22 = create(:transaction, invoice_id: @invoice_3.id, result: 1)
    @transaction_23 = create(:transaction, invoice_id: @invoice_3.id, result: 1)
    @transaction_24 = create(:transaction, invoice_id: @invoice_3.id, result: 1)
    @transaction_25 = create(:transaction, invoice_id: @invoice_3.id, result: 1)
    @transaction_26 = create(:transaction, invoice_id: @invoice_3.id, result: 1)
    @transaction_27 = create(:transaction, invoice_id: @invoice_3.id, result: 1)

    @transaction_28 = create(:transaction, invoice_id: @invoice_4.id, result: 1)
    @transaction_29 = create(:transaction, invoice_id: @invoice_4.id, result: 1)
    @transaction_30 = create(:transaction, invoice_id: @invoice_4.id, result: 1)
    @transaction_31 = create(:transaction, invoice_id: @invoice_4.id, result: 1)
    @transaction_32 = create(:transaction, invoice_id: @invoice_4.id, result: 1)
    @transaction_33 = create(:transaction, invoice_id: @invoice_4.id, result: 1)

    @transaction_34 = create(:transaction, invoice_id: @invoice_5.id, result: 1)
    @transaction_35 = create(:transaction, invoice_id: @invoice_5.id, result: 1)
    @transaction_36 = create(:transaction, invoice_id: @invoice_5.id, result: 1)
    @transaction_37 = create(:transaction, invoice_id: @invoice_5.id, result: 1)
    @transaction_38 = create(:transaction, invoice_id: @invoice_5.id, result: 1)


    @merchant_2 = create(:merchant)

    @item_2 = create(:item, merchant: @merchant_2)
    @item_3 = create(:item, merchant: @merchant_2)
    @item_4 = create(:item, merchant: @merchant_2)
    @item_5 = create(:item, merchant: @merchant_2)
    @item_6 = create(:item, merchant: @merchant_2)
    @item_7 = create(:item, merchant: @merchant_2)

    @customer_7 = create(:customer)
    @customer_8 = create(:customer)
    @customer_9 = create(:customer)
    @customer_10 = create(:customer)
    @customer_11 = create(:customer)
    @customer_12 = create(:customer)

    @invoice_7 = create(:invoice)
    @invoice_8 = create(:invoice)
    @invoice_9 = create(:invoice)
    @invoice_10 = create(:invoice)
    @invoice_11 = create(:invoice)

    @invoice_item_5 = create(:invoice_item, item: @item_2, invoice: @invoice_7, status: 1, created_at: "Sun, 18 Apr 2021 21:37:10 UTC +00:00")
    @invoice_item_6 = create(:invoice_item, item: @item_3, invoice: @invoice_7, status: 1, created_at: "Sun, 4 Apr 2021 21:37:10 UTC +00:00")
    @invoice_item_7 = create(:invoice_item, item: @item_4, invoice: @invoice_8, status: 1, created_at: "Sun, 11 Apr 2021 21:37:10 UTC +00:00")
    @invoice_item_8 = create(:invoice_item, item: @item_5, invoice: @invoice_8, status: 1, created_at: "Mon, 5 Apr 2021 21:37:10 UTC +00:00")
    @invoice_item_9 = create(:invoice_item, item: @item_6, invoice: @invoice_8, status: 2, created_at: "Mon, 12 Apr 2021 21:37:10 UTC +00:00")

    @transaction_39 = create(:transaction)
    @transaction_40 = create(:transaction)
    @transaction_41 = create(:transaction)
    @transaction_42 = create(:transaction)
    @transaction_43 = create(:transaction)
    @invoice_7.transactions << [@transaction_39, @transaction_40, @transaction_41, @transaction_42, @transaction_43]

    @transaction_44 = create(:transaction)
    @transaction_45 = create(:transaction)
    @transaction_46 = create(:transaction)
    @transaction_47 = create(:transaction)
    @invoice_8.transactions << [@transaction_44, @transaction_45, @transaction_46, @transaction_47]

    @transaction_48 = create(:transaction)
    @transaction_49 = create(:transaction)
    @transaction_50 = create(:transaction)
    @invoice_9.transactions << [@transaction_48, @transaction_49, @transaction_50]

    @transaction_51 = create(:transaction)
    @transaction_52 = create(:transaction)
    @invoice_10.transactions << [@transaction_51, @transaction_52]

    @transaction_53 = create(:transaction)
    @invoice_11.transactions << [@transaction_53]

    visit "/merchants/#{@merchant_1.id}/dashboard"
  end

  describe 'I visit a merchant dashboard' do
    it "Then I see the name of my merchant" do
      expect(page).to have_content(@merchant_1.name)
    end
  end

  describe 'merchant dashboard links' do
    it "to merchant invoices index" do
      expect(page).to have_content("Merchant Invoices Index")

      click_link("Merchant Invoices Index")
      expect(page).to have_current_path("/merchants/#{@merchant_1.id}/invoices")
    end
  end

  describe 'merchant dashboard links' do
    it "to merchant items index" do
      expect(page).to have_content("Merchant Items Index")

      click_link("Merchant Items Index")

      expect(page).to have_current_path("/merchants/#{@merchant_1.id}/items")
    end
  end

  describe 'merchant dashboard' do
    it "displays names of top 5 customers by number of successful transactions" do
      within "#top_five" do
        expect(page).to have_content("Top Five Customers")
        expect(page).to have_content(@customer_2.full_name)
        expect(page).to have_content(@customer_1.full_name)
        expect(page).to have_content(@customer_3.full_name)
        expect(page).to_not have_content(@customer_4.full_name)
      end
    end

    xit "displays items and their invoices that are ready to ship" do
      within "#ready_to_ship" do
        visit "/merchants/#{@merchant_2.id}/dashboard"
        expect(page).to have_content("Items Ready to Ship")
        expect(page).to have_content(@invoice_7.id)
        expect(page).to have_content(@item_2.name)
        expect(page).to have_content(@item_3.name)

        expect(page).to have_content(@invoice_8.id)
        expect(page).to have_content(@item_4.name)
        expect(page).to have_content(@item_5.name)
        expect(page).to_not have_content(@item_6.name)

      end
    end

    xit "displays date invoice was created next to each item ordered oldest to newest" do
      within "#ready_to_ship" do
        visit "/merchants/#{@merchant_2.id}/dashboard"
        merchant_2 = create(:merchant)

        item_2 = create(:item, merchant: merchant_2)
        item_3 = create(:item, merchant: merchant_2)
        item_4 = create(:item, merchant: merchant_2)
        item_5 = create(:item, merchant: merchant_2)
        item_6 = create(:item, merchant: merchant_2)
        item_7 = create(:item, merchant: merchant_2)

        customer_7 = create(:customer)

        invoice_7 = create(:invoice, customer_id: customer_7.id, created_at: "Sun, 18 Apr 2021 21:37:10 UTC +00:00")
        invoice_8 = create(:invoice, customer_id: customer_7.id, created_at: "Sun, 4 Apr 2021 21:37:10 UTC +00:00")
        invoice_9 = create(:invoice, customer_id: customer_7.id, created_at: "Sun, 11 Apr 2021 21:37:10 UTC +00:00")
        invoice_10 = create(:invoice, customer_id: customer_7.id, created_at: "Mon, 5 Apr 2021 21:37:10 UTC +00:00")
        invoice_11 = create(:invoice, customer_id: customer_7.id, created_at: "Mon, 12 Apr 2021 21:37:10 UTC +00:00")
        invoice_12 = create(:invoice, customer_id: customer_7.id, created_at: "Mon, 19 Apr 2021 21:37:10 UTC +00:00")

        invoice_item_7 = create(:invoice_item, item_id: item_2.id, invoice_id: invoice_7.id, status: 0)
        invoice_item_8 = create(:invoice_item, item_id: item_3.id, invoice_id: invoice_8.id, status: 0)
        invoice_item_9 = create(:invoice_item, item_id: item_4.id, invoice_id: invoice_9.id, status: 0)
        invoice_item_10 = create(:invoice_item, item_id: item_5.id, invoice_id: invoice_10.id, status: 0)
        invoice_item_11 = create(:invoice_item, item_id: item_6.id, invoice_id: invoice_11.id, status: 0)
        invoice_item_12 = create(:invoice_item, item_id: item_7.id, invoice_id: invoice_12.id, status: 0)

        expect(item_3.name).to appear_before(item_5.name)
        expect(item_5.name).to appear_before(item_4.name)
        expect(item_4.name).to appear_before(item_6.name)
        expect(item_6.name).to appear_before(item_2.name)
        expect(item_2.name).to appear_before(item_7.name)

        expect(item_3.formatted_date).to appear_before(item_5.formatted_date)
        expect(item_5.formatted_date).to appear_before(item_4.formatted_date)
        expect(item_4.formatted_date).to appear_before(item_6.formatted_date)
        expect(item_6.formatted_date).to appear_before(item_2.formatted_date)
        expect(item_2.formatted_date).to appear_before(item_7.formatted_date)
      end
    end
  end
end
