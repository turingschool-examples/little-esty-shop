require "rails_helper"

RSpec.describe "Merchant Dashboard", type: :feature do
  before do
    @merchant = create :merchant
    @item1 = create :item, {merchant_id: @merchant.id}
    @item2 = create :item, {merchant_id: @merchant.id}
    @item3 = create :item, {merchant_id: @merchant.id}

    @customer = create :customer
    @invoice1 = create :invoice, {customer_id: @customer.id}
    @invoice2 = create :invoice, {customer_id: @customer.id}
    @invoice_item1 = create :invoice_item, {invoice_id: @invoice1.id, item_id: @item1.id, quantity: 1, unit_price: 22, status: 0}
    @invoice_item2 = create :invoice_item, {invoice_id: @invoice1.id, item_id: @item2.id, quantity: 1, unit_price: 45, status: 1}
    @invoice_item3 = create :invoice_item, {invoice_id: @invoice2.id, item_id: @item3.id, quantity: 1, unit_price: 72, status: 2}

    visit merchant_dashboard_index_path(@merchant)
  end

  describe "display" do
    it "displays merchant name", :vcr do
      expect(page).to have_content(@merchant.name)
    end

    it "has a link to view all merchant items", :vcr do
      expect(page).to have_link("Merchant Items")

      click_link "Merchant Items"
      expect(current_path).to eq(merchant_items_path(@merchant))
    end

    it "has a link to view all merchant invoices", :vcr do
      expect(page).to have_link("Merchant Invoices")

      click_link "Merchant Invoices"
      expect(current_path).to eq(merchant_invoices_path(@merchant))
    end

    it "displays items ready to ship with a link to the item's invoice", :vcr do
      expect(@merchant.items_ready_to_ship).to eq([@invoice_item1, @invoice_item2])

      within("#items_to_ship-#{@invoice_item1.id}") do
        expect(page).to have_link(@invoice_item1.invoice.id)
        expect(page).to have_content(@item1.name)
        expect(page).to have_content(@invoice1.id)
      end

      within("#items_to_ship-#{@invoice_item2.id}") do
        expect(page).to have_link(@invoice_item2.invoice.id)
        expect(page).to have_content(@item2.name)
        expect(page).to have_content(@invoice1.id)
      end
    end

    it "displays items ready to ship with the date the invoice was created", :vcr do
      within("#items_to_ship-#{@invoice_item2.id}") do
        expect(page).to have_link(@invoice_item2.invoice.id)
        expect(page).to have_content(@item2.name)
        expect(page).to have_content(@invoice1.id)
        expect(page).to have_content(@invoice_item2.invoice.created_at.strftime("%A, %B %d, %Y"))
      end

      within("#items_to_ship-#{@invoice_item1.id}") do
        expect(page).to have_link(@invoice_item1.invoice.id)
        expect(page).to have_content(@item1.name)
        expect(page).to have_content(@invoice1.id)
        expect(page).to have_content(@invoice_item1.invoice.created_at.strftime("%A, %B %e, %Y"))
      end

      expect(@item1.name).to appear_before(@item2.name)
    end

    it '::top_customers' do
      merchant_1 = create(:merchant)
      item = create :item, {merchant_id: merchant_1.id}

      customer_1 = create(:customer)
      invoice_1 = create(:invoice, customer_id: customer_1.id)
      invoice_item_1 = create(:invoice_item, invoice_id: invoice_1.id, item_id: item.id)
      transactions_list_1 = create_list(
        :transaction, 27,
        credit_card_expiration_date: "0 Seconds From Now",
        credit_card_number: "346785678",
        invoice_id: invoice_1.id,
        result: 0)

      customer_2 = create(:customer)
      invoice_2 = create(:invoice, customer_id: customer_2.id)
      invoice_item_2 = create(:invoice_item, invoice_id: invoice_2.id, item_id: item.id)
      transactions_list_1 = create_list(
        :transaction, 12,
        credit_card_expiration_date: "0 Seconds From Now",
        credit_card_number: "223385678",
        invoice_id: invoice_2.id,
        result: 0)

      customer_3 = create(:customer)
      invoice_3 = create(:invoice, customer_id: customer_3.id)
      invoice_item_3 = create(:invoice_item, invoice_id: invoice_3.id, item_id: item.id)
      transactions_list_1 = create_list(
        :transaction, 44,
        credit_card_expiration_date: "0 Seconds From Now",
        credit_card_number: "12343785678",
        invoice_id: invoice_3.id,
        result: 0)

      customer_4 = create(:customer)
      invoice_4 = create(:invoice, customer_id: customer_4.id)
      invoice_item_4 = create(:invoice_item, invoice_id: invoice_4.id, item_id: item.id)
      transactions_list_1 = create_list(
        :transaction, 52,
        credit_card_expiration_date: "0 Seconds From Now",
        credit_card_number: "5436723678",
        invoice_id: invoice_4.id,
        result: 0)

      customer_5 = create(:customer)
      invoice_5 = create(:invoice, customer_id: customer_5.id)
      invoice_item_5 = create(:invoice_item, invoice_id: invoice_5.id, item_id: item.id)
      transactions_list_1 = create_list(
        :transaction, 65,
        credit_card_expiration_date: "0 Seconds From Now",
        credit_card_number: "512385678",
        invoice_id: invoice_5.id,
        result: 0)

      customer_6 = create(:customer)
      invoice_6 = create(:invoice, customer_id: customer_6.id)
      invoice_item_6 = create(:invoice_item, invoice_id: invoice_6.id, item_id: item.id)
      transactions_list_1 = create_list(
        :transaction, 23,
        credit_card_expiration_date: "0 Seconds From Now",
        credit_card_number: "56785234",
        invoice_id: invoice_6.id,
        result: 0)

      visit merchant_dashboard_index_path(merchant_1)

      within("#top_customers") do
        expect(page).to have_content("Customer: #{customer_5.full_name} - Total Transactions: 65")
        expect(page).to have_content("Customer: #{customer_4.full_name} - Total Transactions: 52")
        expect(page).to have_content("Customer: #{customer_3.full_name} - Total Transactions: 44")
        expect(page).to have_content("Customer: #{customer_1.full_name} - Total Transactions: 27")
        expect(page).to have_content("Customer: #{customer_6.full_name} - Total Transactions: 23")
        expect(page).to_not have_content(customer_2)

        expect(customer_5.full_name).to appear_before(customer_4.full_name)
        expect(customer_4.full_name).to appear_before(customer_3.full_name)
        expect(customer_3.full_name).to appear_before(customer_1.full_name)
        expect(customer_1.full_name).to appear_before(customer_6.full_name)
      end
    end
  end
end
