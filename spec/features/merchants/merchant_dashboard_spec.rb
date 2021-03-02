require "rails_helper"
require 'time'
RSpec.describe 'Merchant Dashboard' do
  before :each do
    @mer_1 = create(:merchant)
  end

  it "shows merchant names on the dashboard" do
    visit merchant_dashboard_index_path(@mer_1)

    expect(page).to have_content("#{@mer_1.name}")
  end

  it "shows links to the merchant's items and invoices index" do
    visit merchant_dashboard_index_path(@mer_1)

    expect(page).to have_link("Merchant Items")
    expect(page).to have_link("Merchant Invoices")
  end

  it "show favorite customers and next to each customer name, I see the number of
      successful transactions they have" do
      cust_1 = create(:customer)
      cust_2 = create(:customer)
      cust_3 = create(:customer)
      cust_4 = create(:customer)
      cust_5 = create(:customer)
      cust_6 = create(:customer)
      cust_7 = create(:customer)
      cust_8 = create(:customer)
      cust_9 = create(:customer)
      cust_10 = create(:customer)
      item_1 = create(:item, merchant_id: @mer_1.id)
      item_2 = create(:item, merchant_id: @mer_1.id)
      item_3 = create(:item, merchant_id: @mer_1.id)
      item_4 = create(:item, merchant_id: @mer_1.id)
      item_5 = create(:item, merchant_id: @mer_1.id)
      item_6 = create(:item, merchant_id: @mer_1.id)
      invoice1 = create(:invoice, customer_id: cust_1.id)
      invoice2 = create(:invoice, customer_id: cust_2.id)
      invoice3 = create(:invoice, customer_id: cust_3.id)
      invoice4 = create(:invoice, customer_id: cust_4.id)
      invoice5 = create(:invoice, customer_id: cust_5.id)
      invoice6 = create(:invoice, customer_id: cust_6.id)
      invoice_item1 = create(:invoice_item, item_id:item_1.id, invoice_id:invoice1.id)
      invoice_item2 = create(:invoice_item, item_id:item_2.id, invoice_id:invoice2.id)
      invoice_item3 = create(:invoice_item, item_id:item_3.id, invoice_id:invoice3.id)
      invoice_item4 = create(:invoice_item, item_id:item_4.id, invoice_id:invoice4.id)
      invoice_item5 = create(:invoice_item, item_id:item_5.id, invoice_id:invoice6.id)
      invoice_item6 = create(:invoice_item, item_id:item_6.id, invoice_id:invoice6.id)
      transaction1 = create(:transaction, result: "success", invoice_id: invoice1.id)
      transaction2 = create(:transaction, result: "failed", invoice_id: invoice1.id)
      transaction2 = create(:transaction, result: "success", invoice_id: invoice2.id)
      transaction2 = create(:transaction, result: "success", invoice_id: invoice2.id)
      transaction3 = create(:transaction, result: "success", invoice_id: invoice1.id)
      transaction4 = create(:transaction, result: "success", invoice_id: invoice4.id)
      transaction5 = create(:transaction, result: "success", invoice_id: invoice5.id)
      transaction6 = create(:transaction, result: "success", invoice_id: invoice3.id)
      transaction7 = create(:transaction, result: "success", invoice_id: invoice3.id)
      transaction8 = create(:transaction, result: "success", invoice_id: invoice6.id)
        visit merchant_dashboard_index_path(@mer_1)

        expect(page).to have_content("Favorite Customers")
        expect(cust_1.first_name).to appear_before(cust_2.first_name)
        expect(cust_2.first_name).to appear_before(cust_3.first_name)
        expect(cust_6.first_name).to appear_before(cust_4.first_name)
        expect(cust_3.first_name).to appear_before(cust_6.first_name)
        expect(page).to have_content("Successful Transactions:2")
  end

  it "shows list of item names that have been ordered and not shipped" do
    InvoiceItem.destroy_all
    Transaction.destroy_all
    Item.destroy_all
    Invoice.destroy_all
    Customer.destroy_all
    cust_1 = create(:customer)
    cust_2 = create(:customer)
    cust_3 = create(:customer)
    cust_4 = create(:customer)
    cust_5 = create(:customer)
    cust_6 = create(:customer)
    cust_7 = create(:customer)
    cust_8 = create(:customer)
    cust_9 = create(:customer)
    cust_10 = create(:customer)
    item_1 = create(:item, name: "item 1", merchant_id: @mer_1.id)
    item_2 = create(:item,  name: "item 2", merchant_id:@mer_1.id)
    item_3 = create(:item, name: "item 3", merchant_id: @mer_1.id)
    item_4 = create(:item, name: "item 4", merchant_id: @mer_1.id)
    item_5 = create(:item, name: "item 5", merchant_id: @mer_1.id)
    item_6 = create(:item, name: "item 6", merchant_id: @mer_1.id)
    item_7 = create(:item, name: "item 7", merchant_id: @mer_1.id)
    invoice1 = create(:invoice, customer_id: cust_1.id, created_at: "2012-03-25 09:54:09 UTC")
    invoice2 = create(:invoice, customer_id: cust_2.id)
    invoice3 = create(:invoice, customer_id: cust_3.id, created_at: "2012-03-10 10:54:10 UTC")
    invoice4 = create(:invoice, customer_id: cust_4.id)
    invoice5 = create(:invoice, customer_id: cust_5.id)
    invoice6 = create(:invoice, customer_id: cust_6.id, created_at: "2012-03-15 14:54:10 UTC")
    invoice7 = create(:invoice, customer_id: cust_7.id, created_at: "2012-03-13 07:54:10 UTC")
    invoice_item1 = create(:invoice_item, item_id:item_1.id, invoice_id:invoice1.id,  status: "pending")
    invoice_item2 = create(:invoice_item, item_id:item_2.id, invoice_id:invoice2.id)
    invoice_item3 = create(:invoice_item, item_id:item_3.id, invoice_id:invoice3.id, status: "packaged")
    invoice_item4 = create(:invoice_item, item_id:item_4.id, invoice_id:invoice4.id)
    invoice_item4 = create(:invoice_item, item_id:item_6.id, invoice_id:invoice7.id, status: "packaged")
    invoice_item5 = create(:invoice_item, item_id:item_5.id, invoice_id:invoice6.id, status: "packaged")
    invoice_item6 = create(:invoice_item, item_id:item_7.id, invoice_id:invoice6.id)
      visit merchant_dashboard_index_path(@mer_1)
      expect(page).to have_content("Items Ready to be shipped")
      expect(page).to have_content(item_1.name)
      expect(page).to have_content(item_3.name)
      expect(page).to have_content(item_5.name)
      expect(page).to have_content(item_6.name)
      expect(page).to have_content(invoice1.id)
      expect(page).to have_content(invoice3.id)
      expect(page).to have_content(invoice7.id)
      expect(page).to have_content(invoice6.id)
      expect(invoice3.created_at.strftime("%A,%B,%d,%Y")).to appear_before(invoice7.created_at.strftime("%A,%B,%d,%Y"))
      expect(invoice7.created_at.strftime("%A,%B,%d,%Y")).to appear_before(invoice6.created_at.strftime("%A,%B,%d,%Y"))
      expect(invoice6.created_at.strftime("%A,%B,%d,%Y")).to appear_before(invoice1.created_at.strftime("%A,%B,%d,%Y"))

  end
end
