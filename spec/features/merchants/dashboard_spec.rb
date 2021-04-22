require 'rails_helper'

RSpec.describe "Merchant Dashboard" do
  before(:each) do
    @merchant = create(:merchant)

    @item_1 = create(:item, merchant: @merchant)
    @item_2 = create(:item, merchant: @merchant)
    @item_3 = create(:item, merchant: @merchant)
    @item_4 = create(:item, merchant: @merchant)
    @item_5 = create(:item, merchant: @merchant)
    @item_6 = create(:item, merchant: @merchant)

    @customer_1 = create(:customer)
    @customer_2 = create(:customer)
    @customer_3 = create(:customer)
    @customer_4 = create(:customer)
    @customer_5 = create(:customer)
    @customer_6 = create(:customer)
    @customer_7 = create(:customer)

    @invoice_1 = Invoice.create!(status: 0, customer_id: @customer_1.id)
    @invoice_2 = Invoice.create!(status: 0, customer_id: @customer_2.id)
    @invoice_3 = Invoice.create!(status: 0, customer_id: @customer_3.id)
    @invoice_4 = Invoice.create!(status: 0, customer_id: @customer_4.id)
    @invoice_5 = Invoice.create!(status: 0, customer_id: @customer_5.id)
    @invoice_6 = Invoice.create!(status: 0, customer_id: @customer_6.id)
    @invoice_7 = Invoice.create!(status: 0, customer_id: @customer_7.id)

    @invoice_item_1 = InvoiceItem.create!(item_id: @item_1.id, invoice_id: @invoice_2.id, quantity: 10, unit_price: 20, status: 0)
    @invoice_item_2 =InvoiceItem.create!(item_id: @item_2.id, invoice_id: @invoice_3.id, quantity: 10, unit_price: 20, status: 2)
    @invoice_item_3 =InvoiceItem.create!(item_id: @item_3.id, invoice_id: @invoice_4.id, quantity: 10, unit_price: 20, status: 1)
    @invoice_item_4 =InvoiceItem.create!(item_id: @item_4.id, invoice_id: @invoice_5.id, quantity: 10, unit_price: 20, status: 1)
    @invoice_item_5 =InvoiceItem.create!(item_id: @item_5.id, invoice_id: @invoice_6.id, quantity: 10, unit_price: 20, status: 2)
    @invoice_item_6 =InvoiceItem.create!(item_id: @item_5.id, invoice_id: @invoice_7.id, quantity: 10, unit_price: 20, status: 2)
    @invoice_item_7 =InvoiceItem.create!(item_id: @item_5.id, invoice_id: @invoice_1.id, quantity: 10, unit_price: 20, status: 2)

    @transaction_1 = Transaction.create!(credit_card_number: "123456789", credit_card_expiration_date: 1021, result: "success", invoice_id: @invoice_1.id)
    @transaction_2 = Transaction.create!(credit_card_number: "123456789", credit_card_expiration_date: 1021, result: "success", invoice_id: @invoice_2.id)
    @transaction_3 = Transaction.create!(credit_card_number: "123456789", credit_card_expiration_date: 1021, result: "success", invoice_id: @invoice_3.id)
    @transaction_4 = Transaction.create!(credit_card_number: "123456789", credit_card_expiration_date: 1021, result: "success", invoice_id: @invoice_4.id)
    @transaction_5 = Transaction.create!(credit_card_number: "123456789", credit_card_expiration_date: 1021, result: "success", invoice_id: @invoice_5.id)
    @transaction_6 = Transaction.create!(credit_card_number: "123456789", credit_card_expiration_date: 1021, result: "success", invoice_id: @invoice_6.id)

    @transaction_7 = Transaction.create!(credit_card_number: "123456789", credit_card_expiration_date: 1021, result: "success", invoice_id: @invoice_7.id)
    @transaction_8 = Transaction.create!(credit_card_number: "123456789", credit_card_expiration_date: 1021, result: "success", invoice_id: @invoice_1.id)
    @transaction_9 = Transaction.create!(credit_card_number: "123456789", credit_card_expiration_date: 1021, result: "failed", invoice_id: @invoice_2.id)
    @transaction_10 = Transaction.create!(credit_card_number: "123456789", credit_card_expiration_date: 1021, result: "success", invoice_id: @invoice_3.id)
    @transaction_11 = Transaction.create!(credit_card_number: "123456789", credit_card_expiration_date: 1021, result: "success", invoice_id: @invoice_4.id)
    @transaction_12 = Transaction.create!(credit_card_number: "123456789", credit_card_expiration_date: 1021, result: "success", invoice_id: @invoice_5.id)
    @transaction_13 = Transaction.create!(credit_card_number: "123456789", credit_card_expiration_date: 1021, result: "failed", invoice_id: @invoice_6.id)
    @transaction_14 = Transaction.create!(credit_card_number: "123456789", credit_card_expiration_date: 1021, result: "success", invoice_id: @invoice_7.id)

    visit "/merchant/#{@merchant.id}/dashboard"
  end

  it "can see merchant name" do
    expect(page).to have_content(@merchant.name)
  end

  it "see links to merchant items index and merchant invoices index" do
    expect(page).to have_link('My Items', href: "/merchant/#{@merchant.id}/items")
    expect(page).to have_link('My Invoices', href: "/merchant/#{@merchant.id}/invoices")
  end

  it 'shows top five favorite customers who have the most successful transactions' do
    expect(page).to have_content("Top 5 Customers")

    within("#favorite_customers") do
      expect(page).to have_content(@customer_1.first_name)
      expect(page).to have_content(@customer_1.last_name)
      expect(page).to have_content(@customer_1.transactions.success_count)

      expect(page).to have_content(@customer_3.first_name)
      expect(page).to have_content(@customer_3.last_name)
      expect(page).to have_content(@customer_3.transactions.success_count)

      expect(page).to have_content(@customer_4.first_name)
      expect(page).to have_content(@customer_4.last_name)
      expect(page).to have_content(@customer_4.transactions.success_count)

      expect(page).to have_content(@customer_5.first_name)
      expect(page).to have_content(@customer_5.last_name)
      expect(page).to have_content(@customer_5.transactions.success_count)

      expect(page).to have_content(@customer_7.first_name)
      expect(page).to have_content(@customer_7.last_name)
      expect(page).to have_content(@customer_7.transactions.success_count)
    end
  end

  it "shows items ready to ship" do
    expect(page).to have_content("Items Ready to Ship")

    within("#inv_items_not_shipped") do
      expect(page).to have_content(@item_1.name)
      expect(page).to have_content(@invoice_2.id)
      expect(page).to have_content(@invoice_2.created_at.strftime("%A, %B %d, %Y"))
      expect(page).to have_content(@item_3.name)
      expect(page).to have_content(@invoice_4.id)
      expect(page).to have_content(@invoice_4.created_at.strftime("%A, %B %d, %Y"))
      expect(page).to have_content(@item_4.name)
      expect(page).to have_content(@invoice_5.id)
      expect(page).to have_content(@invoice_5.created_at.strftime("%A, %B %d, %Y"))

      expect(page).not_to have_content(@item_2.name)
      expect(page).not_to have_content(@item_5.name)
    end
  end
end
