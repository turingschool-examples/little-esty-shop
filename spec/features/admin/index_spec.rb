require "rails_helper"

RSpec.describe "Admin Dashboard", type: :feature do
  it "shows admin dash header", :vcr do
    visit admin_index_path

    within("#admin-header") do
      expect(page).to have_content("Admin Dashboard")
    end
  end

  it "contains links to merchant and invoice admin views", :vcr do
    visit admin_index_path

    within("#dashboard-links") do
      expect(page).to have_link("Merchants View", href: admin_merchants_path)
      expect(page).to have_link("Invoices View", href: admin_invoices_path)
    end
  end

  it "has incomplete invoices section displaying their ids that link to those invoices", :vcr do
    merch = create(:merchant)
    item = create(:item, merchant: merch)
    customer = create(:customer)
    invoice1 = create(:invoice, customer: customer)
    invoice2 = create(:invoice, customer: customer)
    invoice3 = create(:invoice, customer: customer)
    invoice_item1 = create(:invoice_item, invoice: invoice1, item: item, status: 0)
    invoice_item2 = create(:invoice_item, invoice: invoice1, item: item, status: 0)
    invoice_item3 = create(:invoice_item, invoice: invoice1, item: item, status: 2)
    invoice_item4 = create(:invoice_item, invoice: invoice2, item: item, status: 1)
    invoice_item5 = create(:invoice_item, invoice: invoice2, item: item, status: 1)
    invoice_item6 = create(:invoice_item, invoice: invoice2, item: item, status: 2)
    invoice_item7 = create(:invoice_item, invoice: invoice3, item: item, status: 2)
    invoice_item8 = create(:invoice_item, invoice: invoice3, item: item, status: 2)
    invoice_item9 = create(:invoice_item, invoice: invoice3, item: item, status: 2)

    visit admin_index_path

    expect(page).to have_content("Incomplete Invoices:")

    within("#incomplete-invoices-#{invoice1.id}") do
      expect(page).to have_content(invoice1.id.to_s)
      expect(page).to_not have_content(invoice2.id.to_s)
      expect(page).to_not have_content(invoice3.id.to_s)
      expect(page).to have_link(invoice1.id.to_s, href: admin_invoice_path(invoice1.id))
    end

    within("#incomplete-invoices-#{invoice2.id}") do
      expect(page).to have_content(invoice2.id.to_s)
      expect(page).to_not have_content(invoice1.id.to_s)
      expect(page).to_not have_content(invoice3.id.to_s)
      expect(page).to have_link(invoice2.id.to_s, href: admin_invoice_path(invoice2.id))
    end
  end

  it "has incomplete invoices section that includes the date the invoices were created", :vcr do
    merch = create(:merchant)
    item = create(:item, merchant: merch)
    customer = create(:customer)
    invoice1 = create(:invoice, customer: customer)
    invoice2 = create(:invoice, customer: customer)
    invoice3 = create(:invoice, customer: customer)
    invoice_item1 = create(:invoice_item, invoice: invoice1, item: item, status: 0)
    invoice_item2 = create(:invoice_item, invoice: invoice1, item: item, status: 0)
    invoice_item3 = create(:invoice_item, invoice: invoice1, item: item, status: 2)
    invoice_item4 = create(:invoice_item, invoice: invoice2, item: item, status: 1)
    invoice_item5 = create(:invoice_item, invoice: invoice2, item: item, status: 1)
    invoice_item6 = create(:invoice_item, invoice: invoice2, item: item, status: 2)
    invoice_item7 = create(:invoice_item, invoice: invoice3, item: item, status: 2)
    invoice_item8 = create(:invoice_item, invoice: invoice3, item: item, status: 2)
    invoice_item9 = create(:invoice_item, invoice: invoice3, item: item, status: 2)

    visit admin_index_path

    expect(page).to have_content("Incomplete Invoices:")

    within("#incomplete-invoices-#{invoice1.id}") do
      expect(page).to have_content(invoice1.id.to_s)
      expect(page).to have_content(invoice1.created_at.strftime("%A, %B %e, %Y"))
    end

    within("#incomplete-invoices-#{invoice2.id}") do
      expect(page).to have_content(invoice2.id.to_s)
      expect(page).to have_content(invoice2.created_at.strftime("%A, %B %e, %Y"))
    end
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
